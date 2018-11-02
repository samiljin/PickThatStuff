//
//  SpriteMovement.swift
//  PickMeUp
//
//  Created by Sami Iljin on 23/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import SpriteKit

protocol NodeMovement {
    static func perform(for node: SKNode, in scene: PlayableScene)
}
