//
//  Application.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 03/11/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class Game {
    static let shared = Game()
    
    let highScores: HighScoreHandler = UserDefaultsHighScoreHandler()
    
    private init() {}
}
