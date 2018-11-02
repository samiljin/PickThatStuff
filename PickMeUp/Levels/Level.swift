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

    var targets: Array<(moves: [NodeMovement.Type], node: SKNode)> { get }
}
