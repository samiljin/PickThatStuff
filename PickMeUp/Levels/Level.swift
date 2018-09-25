//
//  Level.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

protocol Level {
    init(scene: SKScene)
    
    var scene: SKScene { get }
    var number: Int { get }
    var rounds: Int { get }

    var timeToReactInSeconds: TimeInterval { get }
    
    // Tästä Dictionary missä movementit ja targetit
    var targets: Array<SKSpriteNode> { get }
    
//    var targets1: Array<(move: SpriteMovement, node: SKSpriteNode)> { get }
    
    func startRound()
}
