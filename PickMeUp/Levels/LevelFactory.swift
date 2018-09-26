//
//  LevelFactory.swift
//  PickMeUp
//
//  Created by Sami Iljin on 24/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class LevelFactory {
    func nextLevel() -> Level.Type {
        currentLevelIndex += 1
        
        return LEVELS[currentLevelIndex]
    }
    
    private let LEVELS: [Level.Type] = [
        LevelOne.self,
        LevelTwo.self,
        LevelThree.self,
        LevelFour.self,
        LevelFive.self,
        LevelSix.self,
        LevelSeven.self,
        LevelEight.self
    ]
    
    private var currentLevelIndex = -1
}
