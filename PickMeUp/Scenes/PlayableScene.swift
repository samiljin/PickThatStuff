//
//  PlayableScene.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 04/10/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import SpriteKit

protocol PlayableScene {
    func getPlayableRect() -> CGRect
    func setGravity(to vector: CGVector)
}
