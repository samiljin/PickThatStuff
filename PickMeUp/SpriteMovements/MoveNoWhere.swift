//
//  MoveNoWhere.swift
//  PickMeUp
//
//  Created by Sami Iljin on 24/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class MoveNoWhere: SpriteMovement {
    static func perform(for node: SKSpriteNode, in scene: PlayableScene) {
        let rect = scene.getPlayableRect()

        let x = Int(arc4random_uniform(UInt32(rect.maxX - node.size.width)))
        let y = Int(arc4random_uniform(UInt32(rect.maxY - node.size.height)))

        scene.setGravity(to: CGVector.zero)
        node.position = CGPoint(x: x, y: y)
    }
}
