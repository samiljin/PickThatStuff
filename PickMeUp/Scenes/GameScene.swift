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
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        startNextLevel()
    }
    
    func startNextLevel() {
        if let currentLevel = self.currentLevel {
            removeChildren(in: currentLevel.targets)
        }
        
        let level = levelFactory.nextLevel().init(scene: self)
        
        resetHitCount()
        resetCurrentRound()
        
        self.currentLevel = level
        level.startRound()
    }
    
    func onTargetHit(target: TargetNode) {
        guard let level = currentLevel else { return }
        
        points += 1
        targetHitCount += 1

        if targetHitCount == level.targets.count {
            resetHitCount()
            
            if currentRound == level.rounds {
                startNextLevel()
            } else {
                currentRound += 1
                level.startRound()
            }
        }
    }
    
    private func resetHitCount() {
        targetHitCount = 0
    }
    
    private func resetCurrentRound() {
        currentRound = 0
    }
    
    func touchDown(atPoint point : CGPoint) {
        guard let node = self.nodes(at: point).first as? TargetNode else { return }
        
        onTargetHit(target: node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
}


