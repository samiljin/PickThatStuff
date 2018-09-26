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
    var currentLevel: Level?
    
    var currentRound = 0 {
        didSet {
            print("round: \(currentRound)")
        }
    }
    
    var targetHitCount = 0
    
    var points = 0 {
        didSet {
            print("points: \(points)")
        }
    }
    
    let levelFactory = LevelFactory()
    var timer: Timer?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
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
        
        initTimerFor(level: level)
    }
    
    private func resetHitCount() {
        targetHitCount = 0
    }
    
    private func resetCurrentRound() {
        currentRound = 0
    }
    
    func onGameOver() {
        timer?.invalidate()
        
        print("GAME OVER!!")
    }
    
    private func initTimerFor(level: Level) {
        timer = Timer.scheduledTimer(withTimeInterval: level.timeToReactInSeconds, repeats: false) {
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
}


