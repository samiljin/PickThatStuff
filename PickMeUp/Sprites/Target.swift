//
//  Target.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class TargetNode : SKSpriteNode {
    let view: SKView
    
    init(view: SKView, scene: SKScene) {
        self.view = view

        let texture = SKTexture(imageNamed: "target")
        
        let size = CGSize(
            width: view.bounds.height * 0.05,
            height: view.bounds.height * 0.05
        )
        
        super.init(texture: texture, color: UIColor.clear, size: size)
    }
    
    func spawnAtRandomLocation() {
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        
        let x = Int(arc4random_uniform(UInt32(maxX - size.width))) + Int(size.width)
        let y = Int(arc4random_uniform(UInt32(maxY - size.height))) + Int(size.height)
        
        position = CGPoint(x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
