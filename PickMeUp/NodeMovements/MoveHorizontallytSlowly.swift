//
//  MoveRightOrLeft.swift
//  PickMeUp
//
//  Created by Sami Iljin on 26/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class MoveHorizontallytSlowly: NodeMovement {
    static func perform(for node: SKNode, in scene: PlayableScene) {
        let rect = scene.getPlayableRect()
        
        let x = Int(arc4random_uniform(UInt32(rect.maxX - node.frame.size.width))) + Int(node.frame.size.width)
        let y = Int(arc4random_uniform(UInt32(rect.maxY - node.frame.size.height))) + Int(node.frame.size.height)

        let impulsePower = arc4random_uniform(UInt32(10)) + 5
        scene.setGravity(to: CGVector.zero)

        node.position = CGPoint(x: x, y: y)
        node.physicsBody?.friction = 1
        node.physicsBody?.applyImpulse(CGVector(dx: Int(impulsePower), dy: 0))
    }
}
