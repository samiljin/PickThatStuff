//
//  GameViewController.swift
//  PickMeUp
//
//  Created by Sami Iljin on 22/09/2018.
//  Copyright © 2018 Sami Iljin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let scene = GameScene(size: view.bounds.size)
        let scene = StartUpScene(size: view.bounds.size)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
