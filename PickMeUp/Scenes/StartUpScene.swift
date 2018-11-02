//
//  StartUpScene.swift
//  PickTheStuff
//
//  Created by Sami Iljin on 17/10/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import Foundation
import GameplayKit

class StartUpScene : SKScene {
    var backgroundTargets: Array<TargetNode> = []
    
    override func didMove(to view: SKView) {
        for _ in 3...Int(arc4random_uniform(8) + 3) {
            backgroundTargets.append(TargetNode(view: view, scene: self))
        }

        let physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody.friction = 0
        self.physicsBody = physicsBody
        
        backgroundColor = .white
    
        buttons = [
            startNewGameButton,
            settingsButton,
            highScoresButton
        ]
        
        buttons.forEach { addChild($0) }
        
        backgroundTargets.forEach {
            node in
            addChild(node)
            MoveRandomlySlowly.perform(for: node, in: PlayableSceneAdapter(scene: self))
        }
    }
    
    func startNewGamePressed() {
        animateButtonsFadeOut(firstButtonToFade: startNewGameButton) {
            [unowned self] in
            self.fadeOutTargets(completion: self.moveToGameScene)
        }
    }
    
    func settingsPressed() {
        animateButtonsFadeOut(firstButtonToFade: settingsButton, completion: nil)
    }
    
    func highScoresPressed() {
        animateButtonsFadeOut(firstButtonToFade: highScoresButton, completion: nil)
    }
    
    private func animateButtonsFadeOut(firstButtonToFade: Button, completion: (() -> Void)?) {
        var buttons = self.buttons
        let button = buttons.remove(at: buttons.index(of: firstButtonToFade)!)
        buttons.insert(button, at: 0)
        self.run(action: dismissAction, for: buttons, completion: completion)
    }
    
    private func fadeOutTargets(completion: (() -> Void)?) {
        self.run(action: dismissAction, for: backgroundTargets, completion: completion)
    }
    
    private func run(action: SKAction, for nodes: [SKNode], completion: (() -> Void)?) {
        if nodes.count == 0 {
            completion?()
            return
        }
        
        var nodes = nodes
        let node = nodes.removeFirst()
        
        node.run(action) {
            [unowned self] in
            self.run(action: action, for: nodes, completion: completion)
        }
    }
    
    private func moveToGameScene() {
        self.view?.presentScene(GameScene(size: self.size))
    }
    
    var buttons: [Button] = []
    
    private let dismissAction = SKAction.group(
        [SKAction.scale(to: 0, duration: 0.2),
         SKAction.fadeAlpha(to: 0, duration: 0.2)
    ])
    
    private lazy var settingsButton: Button = {
        let button = Button(withText: "Settings", size: buttonSize)
        button.position = CGPoint(x: self.frame.maxX / 2, y: self.frame.maxY / 2)
        button.onTap = settingsPressed
        return button
    }()
    
    private lazy var startNewGameButton: Button = {
        let button = Button(withText: "Start Game", size: buttonSize)
        button.position = CGPoint(x: self.frame.maxX / 2, y: self.settingsButton.frame.maxY + buttonSize.height / 2 + 15)
        button.onTap = startNewGamePressed
        return button
    }()
    
    private lazy var highScoresButton: Button = {
        let button = Button(withText: "Highscores", size: buttonSize)
        button.position = CGPoint(x: self.frame.maxX / 2, y: self.settingsButton.frame.minY - buttonSize.height / 2 - 15)
        button.onTap = highScoresPressed
        return button
    }()
    
    private var buttonSize: CGSize {
        get {
            return CGSize(width: self.frame.maxX * 0.7, height: 50)
        }
    }
}

class PlayableSceneAdapter : PlayableScene {
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func getPlayableRect() -> CGRect {
        return scene.frame
    }
    
    func setGravity(to vector: CGVector) {
        scene.physicsWorld.gravity = vector
    }
}
