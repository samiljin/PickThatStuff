//
//  GameState.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class GameState {
    static let shared = GameState()
    
    func getPoints() -> Int {
        return self.points
    }
    
    func addPoints(points: Int) {
        self.points += points
    }
    
    func resetPoints() {
        self.points = 0
    }
    
    private var points = 0
}
