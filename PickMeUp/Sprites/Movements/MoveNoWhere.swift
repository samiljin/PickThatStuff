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
    static func perform(for node: SKSpriteNode, in scene: SKScene) {
        let maxX = scene.view!.bounds.maxX
        let maxY = scene.view!.bounds.maxY
        
        let x = Int(arc4random_uniform(UInt32(maxX - node.size.width))) + Int(node.size.width)
        let y = Int(arc4random_uniform(UInt32(maxY - node.size.height))) + Int(node.size.height)
        
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        node.position = CGPoint(x: x, y: y)
    }
}
