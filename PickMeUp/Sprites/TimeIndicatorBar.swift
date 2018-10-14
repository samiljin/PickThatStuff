//
//  TimeBar.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 13/10/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class TimeIndicatorBar : SKSpriteNode {
    let width: CGFloat
    let height: CGFloat = 10
    let initialBarColor: UIColor = .green
    
    init(view: SKView) {
        self.width = view.frame.width
        
        let size = CGSize(width: width, height: height)
        super.init(texture: nil, color: initialBarColor, size: size)
        
        anchorPoint = CGPoint(x: 0, y: 0)
        position = CGPoint(x: 0, y: view.frame.height - self.height)
    }
    
    func animate(duration: TimeInterval) {
        let decreaseSize = SKAction.resize(toWidth: 0, duration: duration)
        let changeColor = SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: duration)
        
        let animationGroup = SKAction.group([decreaseSize, changeColor])
        
        self.run(animationGroup)
    }
    
    func reset() {
        removeAllActions()
        
        self.size = CGSize(width: width, height: height)
        self.color = initialBarColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
