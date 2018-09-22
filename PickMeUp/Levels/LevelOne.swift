//
//  LevelOne.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class LevelOne : Level {
    var timeToReactInMillis: Int
    var totalHitsToGetToNextLevel: Int
    
    init() {
        self.timeToReactInMillis = 3000
        self.totalHitsToGetToNextLevel = 10
    }
    
    func calculatePointsForHit(reactionTimeInMillis: Int) -> Int {
        return 1
    }
}
