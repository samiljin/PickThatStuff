//
//  GameState.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation

class GameState {
    var timer: Timer?
    var onGameOver: (() -> Void)?
    var onPointsChanged: (() -> Void)?
    var targetShouldMove: (() -> Void)?
    
    var currentLevel: Level?
    
    func start(level: Level) {
        self.currentLevel = level
        initTimer()
        
        self.targetShouldMove?()
    }
    
    func getPoints() -> Int {
        return self.points
    }
    
    func onTargetHit() {
        guard let level = currentLevel else { return }
        
        self.points += level.calculatePointsForHit(reactionTimeInMillis: 500)
        self.targetShouldMove?()
    }
    
    private func initTimer() {
        guard let level = currentLevel else { return }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: level.timeToReactInSeconds, repeats: false) {
            [unowned self] _ in
            self.onGameOver?()
        }
    }
    
    private var points = 0 {
        didSet {
            self.onPointsChanged?()
        }
    }
}

