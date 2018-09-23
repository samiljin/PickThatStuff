//
//  SpawnAtRandomLocation.swift
//  PickMeUp
//
//  Created by Sami Iljin on 23/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class SpawnAtRandomLocation : SpriteMovement {
    func perform(for node: SKSpriteNode, in view: SKView) {
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        
        let x = Int(arc4random_uniform(UInt32(maxX - node.size.width))) + Int(node.size.width)
        let y = Int(arc4random_uniform(UInt32(maxY - node.size.height))) + Int(node.size.height)
        
        node.position = CGPoint(x: x, y: y)
    }
}
