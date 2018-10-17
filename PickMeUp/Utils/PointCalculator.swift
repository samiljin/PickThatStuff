//
//  PointCalculator.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 14/10/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

struct PointCalculator {
    enum ReactionLevel {
        case superFast
        case fast
        case ok
        case justInTime
    }
    
    static func execute(level: Level, round: Int, timeLeftOnRound: Double) -> Double {
        // TODO: Notify the reaction level for the round so we
        // are able to make a specific sounds based on the reaction level.
        let _ = calculateReactionLevel(level: level, timeLeftOnRound: timeLeftOnRound)
        
        
        return 1
    }
    
    private static func calculateReactionLevel(level: Level, timeLeftOnRound: Double) -> ReactionLevel {
        // TODO: Implement a logic to calculate the reaction level based on the level number.
        // Example:
        // At the first levels, its superfast if you need only 10% of the time to to react,
        // but at higher levels 30% of the time used can be super fast because they are harder and
        // there are not that much time.
        
        return .ok
    }
}
