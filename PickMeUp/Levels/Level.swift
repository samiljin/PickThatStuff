//
//  Level.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

protocol Level {
    var timeToReactInMillis: Int { get }
    var totalHitsToGetToNextLevel: Int { get }
    func calculatePointsForHit(reactionTimeInMillis: Int) -> Int
}
