//
//  Target.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class TargetNode : SKShapeNode {
    let view: SKView
    
    init(view: SKView, scene: SKScene) {
        self.view = view
        
        let size = CGSize(
            width: view.bounds.height * 0.05,
            height: view.bounds.height * 0.05
        )
    
        super.init()
        
        path = CGPath(
            rect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
            transform: nil
        )
        
        lineWidth = 2.0
        fillColor = .blue
        strokeColor = .black
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = true
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
