//
//  Button.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 17/10/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class Button : SKSpriteNode {
    var onTap: (() -> Void)?
    
    init(withText text: String, size: CGSize) {
        self.text = text
        
        super.init(texture: nil, color: .green, size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        zPosition = 100
        isUserInteractionEnabled = true
        
        let textLabel = SKLabelNode(text: text)
        textLabel.horizontalAlignmentMode = .center
        textLabel.verticalAlignmentMode = .center
        textLabel.fontSize = size.height * 0.4
        textLabel.fontColor = .black
        textLabel.zPosition = 1
        addChild(textLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAllActions()
        run(SKAction.scale(to: 1.1, duration: 0.2))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAllActions()
        run(SKAction.scale(to: 1.0, duration: 0.2))
        
        onTap?()
    }
    
    private let text: String
}
