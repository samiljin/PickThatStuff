//
//  UserDefaultHighScoreHandler.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 02/11/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class UserDefaultsHighScoreHandler : HighScoreHandler {
    let defaults = UserDefaults.standard
    let highScoreKey = "HighScoreKey"
    let topScoresToHold = 10
    
    func get(top number: Int) -> [Int] {
        assert(number <= topScoresToHold)
        
        if var result = defaults.object(forKey: highScoreKey) as? [Int] {
            result.sort()
            
            return Array(result.prefix(number))
        } else {
            return []
        }
    }
    
    func add(points: Int) {
        var results = get(top: topScoresToHold)
        results.append(points)
        let newResults = Array(results.prefix(topScoresToHold))
        defaults.set(newResults, forKey: highScoreKey)
    }
}
