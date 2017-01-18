//
//  EndGame.swift
//  Pong
//
//  Created by Michal Lučanský on 17.1.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import SpriteKit


class EndGameLost: SKScene{

private var mainMenu = SKLabelNode()
private var playAgain = SKLabelNode()
    
    


    override func didMove(to view: SKView) {
        mainMenu = childNode(withName: "MainMenu") as! SKLabelNode
        playAgain = childNode(withName: "PlayAgainLabel") as! SKLabelNode
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
        let location = touch.location(in: self)
            if let touchName = atPoint(location).name{
            
                switch touchName {
                case "MainMenu":
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = MainMenu(fileNamed: "MainMenu") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            
                            // Present the scene
                            view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                            
                        }
                    }
                    
                case "PlayAgainLabel":
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = Pong(fileNamed: "PongScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            
                            // Present the scene
                            view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                            
                        }
                    }
                default:
                    break
                }
            
            }
        
        
        }
    }







}
