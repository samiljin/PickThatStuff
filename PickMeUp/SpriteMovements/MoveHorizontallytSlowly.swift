//
//  MoveRightOrLeft.swift
//  PickMeUp
//
//  Created by Sami Iljin on 26/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class MoveHorizontallytSlowly: SpriteMovement {
    static func perform(for node: SKSpriteNode, in scene: PlayableScene) {
        let rect = scene.getPlayableRect()
        
        let x = Int(arc4random_uniform(UInt32(rect.maxX - node.size.width))) + Int(node.size.width)
        let y = Int(arc4random_uniform(UInt32(rect.maxY - node.size.height))) + Int(node.size.height)

        let impulsePower = arc4random_uniform(UInt32(15)) + 5
        scene.setGravity(to: CGVector.zero)

        node.position = CGPoint(x: x, y: y)
        node.physicsBody?.applyImpulse(CGVector(dx: Int(impulsePower), dy: 0))
    }
}
