//
//  HighScoreHandler.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 02/11/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

protocol HighScoreHandler {
    func get(top number: Int) -> [Int]
    func add(points: Int)
}
