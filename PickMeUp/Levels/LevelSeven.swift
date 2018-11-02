//
//  LevelSeven.swift
//  PickMeUp
//
//  Created by Sami Iljin on 26/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class LevelSeven : Level {
    var scene: SKScene
    var number: Int
    var rounds: Int
    
    var timeToReactInSeconds: TimeInterval
    var targets: Array<(moves: [NodeMovement.Type], node: SKNode)>
    
    required init(scene: SKScene) {
        self.scene = scene
        self.number = 2
        self.rounds = 20
        self.timeToReactInSeconds = 3.0
        self.targets = [
            (moves: [MoveNoWhere.self], node: TargetNode(view: scene.view!, scene: scene)),
            (moves: [MoveHorizontallytSlowly.self], node: TargetNode(view: scene.view!, scene: scene)),
            (moves: [MoveHorizontallytSlowly.self], node: TargetNode(view: scene.view!, scene: scene))
        ]
    }
}
