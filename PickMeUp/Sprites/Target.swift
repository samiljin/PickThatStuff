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
        
        physicsBody = SKPhysicsBody(circleOfRadius: max(size.width / 2, size.height / 2))
        physicsBody?.allowsRotation = true
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
