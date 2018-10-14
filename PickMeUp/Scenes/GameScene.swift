//
//  GameScene.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let physicsBody = SKPhysicsBody(edgeLoopFrom: getPlayableRect())
        physicsBody.friction = 0
        self.physicsBody = physicsBody
        
        setupNodes()
        startNextLevel()
    }
    
    func setupNodes() {
        addChild(timeIndicatorBar)
    
        hud.position = CGPoint(x: 0, y: frame.height - 10)
        addChild(hud)
    }
    
    func startNextLevel() {
        if let currentLevel = self.currentLevel {
            removeChildren(in: currentLevel.targets.map {$0.node})
        }
        
        self.currentLevel = levelFactory.nextLevel().init(scene: self)
        
        for target in currentLevel!.targets {
            self.addChild(target.node)
        }
        
        resetHitCount()
        resetCurrentRound()
        performMovementsToNodes()
        
        setupTimerAndHUD(level: self.currentLevel!)
    }
    
    private func startNextRound() {
        timeIndicatorBar.reset()
        
        guard let level = currentLevel else { return }
        
        for target in level.targets {
            self.addChild(target.node)
        }
        
        currentRound += 1
        performMovementsToNodes()
        setupTimerAndHUD(level: level)
    }
    
    func setupTimerAndHUD(level: Level) {
        setupTimer(level: level)
        setupHUD(level: level)
    }
    
    func setupTimer(level: Level) {
        timeLeftOnCurrentRound = level.timeToReactInSeconds
        initTimerFor(level: level)
        timeIndicatorBar.animate(duration: level.timeToReactInSeconds)
    }
    
    func setupHUD(level: Level) {
        hud.set(level: level.number)
        hud.set(points: points)
        hud.set(currentRound: currentRound, levelMaxRounds: level.rounds)
    }
    
    func onTargetHit(target: TargetNode) {
        guard let level = currentLevel else { return }
        
        target.removeFromParent()
        points += 1
        targetHitCount += 1

        if targetHitCount == level.targets.count {
            resetHitCount()
            
            if currentRound == level.rounds {
                startNextLevel()
            } else {
                startNextRound()
            }
        }
    }
    
    func performMovementsToNodes() {
        guard let level = currentLevel else { return }
        
        for target in level.targets {
            for movement in target.moves {
                movement.perform(for: target.node, in: self)
            }
        }
    }
    
    private func resetHitCount() {
        targetHitCount = 0
    }
    
    private func resetCurrentRound() {
        currentRound = 1
    }
    
    func onGameOver() {
        print("GAME OVER!!")
    }
    
    private func initTimerFor(level: Level) {
        roundTimer?.invalidate()
        roundTimer = Timer.scheduledTimer(withTimeInterval: level.timeToReactInSeconds, repeats: false) {
            [unowned self] _ in
            self.onGameOver()
        }
    }
    
    func touchDown(atPoint point : CGPoint) {
        guard let node = self.nodes(at: point).first as? TargetNode else { return }
        onTargetHit(target: node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    private var currentLevel: Level?
    private var currentRound = 0
    private var targetHitCount = 0
    private var points = 0
    private var timeLeftOnCurrentRound: TimeInterval = 0

    private lazy var timeIndicatorBar: TimeIndicatorBar = {
        let bar = TimeIndicatorBar(view: self.view!)
        return bar
    }()
    
    private let hud = HUD()
    private let levelFactory = LevelFactory()
    private var roundTimer: Timer?
}

extension GameScene : PlayableScene {
    func getPlayableRect() -> CGRect {
        // TODO: This bugs on the first level because hud childrens are not yeat drawn.
        let statsHeight = hud.calculateAccumulatedFrame().height + timeIndicatorBar.frame.height
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: frame.width,
                          height: frame.height - statsHeight)
        return rect
    }
    
    func setGravity(to vector: CGVector) {
        self.physicsWorld.gravity = vector
    }
}


