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
    
    func performMovements(movements: Array<SpriteMovement>) {
        for movement in movements { movement.perform(for: self, in: view) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
