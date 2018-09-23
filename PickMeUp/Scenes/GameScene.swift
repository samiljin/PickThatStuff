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
    
    var targetNode: TargetNode?
    var gameState: GameState?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        self.gameState = GameState()
        self.gameState?.targetShouldMove = moveTarget
        self.gameState?.onPointsChanged = onPointsChanged
        self.gameState?.onGameOver = onGameOver
        
        self.targetNode = TargetNode(view: view, scene: self)
        self.addChild(targetNode!)
        
        self.gameState?.start(level: LevelOne())
    }
    
    func onGameOver() {
        print("GAME OVER!")
    }
    
    func onPointsChanged() {
        guard let points = self.gameState?.getPoints() else {
            return
        }
        
        print("Points: \(points)")
    }
    
    func moveTarget() {
        guard let nextMovements = gameState?.currentLevel?.nextSpriteMovements() else {
            return
        }
        
        targetNode?.performMovements(movements: nextMovements)
    }
    
    func touchDown(atPoint point : CGPoint) {
        guard let _ = self.nodes(at: point).first as? TargetNode else { return }
        
        gameState!.onTargetHit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
}
