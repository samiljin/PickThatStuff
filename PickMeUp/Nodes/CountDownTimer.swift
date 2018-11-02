//
//  CountDownTimer.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 02/11/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class CountDownTimer : SKNode {
    override init() {
        super.init()
        zPosition = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func count(from: Int, to: Int, completion: (() -> Void)?) {
        assert(from > to)
        
        self.from = from
        self.to = to
        self.current = from
        
        if label == nil { initLabel() }
        
        animateChangeTo(number: from)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [unowned self] timer in
            self.current = self.current - 1
            
            if self.current == 0 {
                timer.invalidate()
                
                self.label?.alpha = 0
                self.label = nil
                
                completion?()
                
                return
            }
            
            self.animateChangeTo(number: self.current)
        }
    }
    
    private func initLabel() {
        guard let from = from else { return }
        
        label = SKLabelNode(text: "\(from)")
        label?.fontColor = .black
        label?.verticalAlignmentMode = .center
        label?.fontSize = 120
        label?.position = CGPoint(x: scene!.frame.width / 2, y: scene!.frame.height / 2)
        addChild(label!)
    }
    
    private func animateChangeTo(number: Int) {
        let sequence = [
            SKAction.scale(to: 1.4, duration: 0.2),
            SKAction.run {
                self.label?.text = "\(number)"
            },
            SKAction.scale(to: 1, duration: 0.3)
        ]
        
        label?.run(SKAction.sequence(sequence))
    }
    
    private var timer: Timer!
    private var from: Int!
    private var to: Int!
    private var current: Int!
    private var label: SKLabelNode?
}
