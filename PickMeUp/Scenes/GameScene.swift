//
//  GameScene.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var statsBarHeight: CGFloat {
        get {
            return self.frame.height * 0.05
        }
    }
    
    let statBarDividerHeight: CGFloat = 1
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        setupScene()
        startNextLevel()
    }
    
    func setupScene() {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: getPlayableRect())
        physicsBody.friction = 0
        self.physicsBody = physicsBody
        
        addChild(timeIndicatorBar)
        addChild(pointLabel)
        addChild(timeLeftOnCurrentRoundLabel)
    }
    
    func startNextLevel() {
        if let currentLevel = self.currentLevel {
            removeChildren(in: currentLevel.targets.map {$0.node})
        }
        
        let level = levelFactory.nextLevel().init(scene: self)
        
        for target in level.targets {
            self.addChild(target.node)
        }
        
        resetHitCount()
        resetCurrentRound()
        
        self.currentLevel = level
        performMovementsToNodes()
        
        timeLeftOnCurrentRound = level.timeToReactInSeconds
        initTimerFor(level: level)
    }
    
    func onTargetHit(target: TargetNode) {
        guard let level = currentLevel else { return }
        
        target.removeFromParent()
        points += 1
        targetHitCount += 1

        if targetHitCount == level.targets.count {
            resetHitCount()
            
            if currentRound == level.rounds {
                startNextLevel()
            } else {
                startNextRound()
            }
        }
    }
    
    func performMovementsToNodes() {
        guard let level = currentLevel else { return }
        
        for target in level.targets {
            for movement in target.moves {
                movement.perform(for: target.node, in: self)
            }
        }
    }
    
    private func startNextRound() {
        timeIndicatorBar.reset()
        
        guard let level = currentLevel else { return }
        
        for target in level.targets {
            self.addChild(target.node)
        }
        
        currentRound += 1
        performMovementsToNodes()
        
        timeLeftOnCurrentRound = level.timeToReactInSeconds
        initTimerFor(level: level)
        timeIndicatorBar.animate(duration: level.timeToReactInSeconds)
    }
    
    private func resetHitCount() {
        targetHitCount = 0
    }
    
    private func resetCurrentRound() {
        currentRound = 0
    }
    
    func onGameOver() {
        print("GAME OVER!!")
    }
    
    private func initTimerFor(level: Level) {
        roundTimer?.invalidate()
        roundTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
            [unowned self] timer in
            self.timeLeftOnCurrentRound -= timer.timeInterval
            
            if self.timeLeftOnCurrentRound <= 0.0 {
                timer.invalidate()
                self.onGameOver()
            }
        }
    }
    
    func touchDown(atPoint point : CGPoint) {
        guard let node = self.nodes(at: point).first as? TargetNode else { return }
        
        onTargetHit(target: node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    private var currentLevel: Level?
    
    private var currentRound = 0 {
        didSet {
            print("round: \(currentRound)")
        }
    }
    
    private var targetHitCount = 0
    
    private var points = 0 {
        didSet {
            pointLabel.text = pointsText
        }
    }
    
    var pointsText: String {
        get {
            return "Points: \(points)"
        }
    }
    
    private lazy var pointLabel: SKLabelNode = {
        let label = SKLabelNode(text: pointsText)
        label.fontSize = self.statsBarHeight / 2
        label.fontColor = UIColor.black
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        let y = frame.maxY - (statsBarHeight - label.calculateAccumulatedFrame().height) / 2
        label.position = CGPoint(x: 15, y: y)
        return label
    }()
    
    private lazy var timeLeftOnCurrentRoundLabel: SKLabelNode = {
        let label = SKLabelNode(text: timeLeftOnCurrentRoundText)
        label.fontSize = self.statsBarHeight / 2
        label.fontColor = UIColor.black
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        let y = frame.maxY - (statsBarHeight - label.calculateAccumulatedFrame().height) / 2
        label.position = CGPoint(x: frame.maxX - 15, y: y)
        return label
    }()
    
    private var timeLeftOnCurrentRound: TimeInterval = 0 {
        didSet {
            timeLeftOnCurrentRoundLabel.text = timeLeftOnCurrentRoundText
        }
    }
    
    private var timeLeftOnCurrentRoundText: String {
        get {
            let formattedString = String(format: "%.2f", timeLeftOnCurrentRound)
            return "Time \(formattedString)"
        }
    }
    
    private lazy var timeIndicatorBar: TimeBar = {
        let bar = TimeBar(view: self.view!)
        return bar
    }()
    
    private let levelFactory = LevelFactory()
    private var roundTimer: Timer?
}

extension GameScene : PlayableScene {
    func getPlayableRect() -> CGRect {
        let rect = CGRect(x: 0,
                          y: 0,
                          width: frame.width,
                          height: frame.height - statsBarHeight - statBarDividerHeight)
        return rect
    }
    
    func setGravity(to vector: CGVector) {
        self.physicsWorld.gravity = vector
    }
}


