//
//  HUD.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 13/10/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

class HUD: SKNode {
    let fontSize: CGFloat = 15
    let margin: CGFloat = 10
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(points: Double) {
        let text = String(format: "Points: %.2f", points)
        
        guard self.pointsLabel == nil else {
            self.pointsLabel?.text = text
            return
        }
        
        pointsLabel = initLabel(with: text)
        pointsLabel?.horizontalAlignmentMode = .left
        pointsLabel?.position = CGPoint(x: margin, y: -margin)
        addChild(pointsLabel!)
    }
    
    func set(level: Int) {
        let text = "Level: \(level)"
        guard let scene = self.scene else { return }
        guard self.levelLabel == nil else {
            self.levelLabel?.text = text
            return
        }
        
        levelLabel = initLabel(with: text)
        levelLabel?.horizontalAlignmentMode = .center
        levelLabel?.position = CGPoint(x: scene.frame.width / 2, y: -margin)
        
        addChild(levelLabel!)
    }
    
    func set(currentRound current: Int, levelMaxRounds max: Int) {
        let text = "Round: \(current)/\(max)"
        
        guard let scene = self.scene else { return }
        guard self.roundLabel == nil else {
            self.roundLabel?.text = text
            return
        }
        
        roundLabel = initLabel(with: text)
        roundLabel?.horizontalAlignmentMode = .right
        roundLabel?.position = CGPoint(x: scene.frame.width - margin, y: -margin)
        
        addChild(roundLabel!)
    }
    
    private func initLabel(with text: String) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontSize = self.fontSize
        label.fontColor = .black
        label.verticalAlignmentMode = .top
        return label
    }
    
    private var pointsLabel: SKLabelNode?
    private var levelLabel: SKLabelNode?
    private var roundLabel: SKLabelNode?
}
