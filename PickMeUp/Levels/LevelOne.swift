//
//  LevelOne.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class LevelOne : Level {
    var totalHitsOnCurrentLevel: Int
    var timeToReactInSeconds: TimeInterval
    var totalHitsToGetToNextLevel: Int
    
    init() {
        self.timeToReactInSeconds = 3.0
        self.totalHitsToGetToNextLevel = 10
        self.totalHitsOnCurrentLevel = 0
    }
    
    func nextSpriteMovements() -> Array<SpriteMovement> {
        return [SpawnAtRandomLocation()]
    }
    
    func calculatePointsForHit(reactionTimeInMillis: Int) -> Int {
        return 1
    }
}
