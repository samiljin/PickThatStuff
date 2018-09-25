//
//  LevelTwo.swift
//  PickMeUp
//
//  Created by Sami Iljin on 25/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class LevelTwo : Level {
    var scene: SKScene
    var number: Int
    var rounds: Int
    
    var timeToReactInSeconds: TimeInterval
    var targets: Array<SKSpriteNode>
    
    required init(scene: SKScene) {
        self.scene = scene
        self.number = 2
        self.rounds = 20
        self.timeToReactInSeconds = 3.0
        self.targets = [
            TargetNode(view: scene.view!, scene: scene),
            TargetNode(view: scene.view!, scene: scene)
        ]
        
        self.targets.forEach {
            [unowned self] in
            self.scene.addChild($0)
        }
    }
    
    func startRound() {
        self.targets.forEach {
            [unowned self] in
            MoveNoWhere.perform(for: $0, in: self.scene)
        }
    }
}
