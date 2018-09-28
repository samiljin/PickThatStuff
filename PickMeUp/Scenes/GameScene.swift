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
        
        let physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody.friction = 0
        self.physicsBody = physicsBody
        
        startNextLevel()
    }
    
    func startNextLevel() {
        if let currentLevel = self.currentLevel {
            removeChildren(in: currentLevel.targets.map {$0.node})
        }
        
        let level = levelFactory.nextLevel().init(scene: self)
        
        for target in level.targets {
            self.addChild(target.node)
        }
        
        resetHitCount()
        resetCurrentRound()
        
        self.currentLevel = level
        performMovementsToNodes()
        
        timeLeftOnCurrentRound = level.timeToReactInSeconds
        initTimerFor(level: level)
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
    
    private func startNextRound() {
        guard let level = currentLevel else { return }
        
        for target in level.targets {
            self.addChild(target.node)
        }
        
        currentRound += 1
        performMovementsToNodes()
        
        timeLeftOnCurrentRound = level.timeToReactInSeconds
        initTimerFor(level: level)
    }
    
    private func resetHitCount() {
        targetHitCount = 0
    }
    
    private func resetCurrentRound() {
        currentRound = 0
    }
    
    func onGameOver() {
        roundTimer?.invalidate()
        
        print("GAME OVER!!")
    }
    
    private func initTimerFor(level: Level) {
        roundTimer?.invalidate()
        roundTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {
            [unowned self] _ in
            self.timeLeftOnCurrentRound -= 0.05
            
            if self.timeLeftOnCurrentRound <= 0.0 {
                self.onGameOver()
            }
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
    
    private var currentRound = 0 {
        didSet {
            print("round: \(currentRound)")
        }
    }
    
    private var targetHitCount = 0
    
    private var points = 0 {
        didSet {
            print(points)
        }
    }
    
    private let levelFactory = LevelFactory()
    
    private var roundTimer: Timer?
    private var timeLeftOnCurrentRound: TimeInterval = 0 {
        didSet {
            print(String(format: "%.2f", timeLeftOnCurrentRound))
        }
    }
}


