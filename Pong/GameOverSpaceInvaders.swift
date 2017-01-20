//
//  GameOverSpaceInvaders.swift
//  Pong
//
//  Created by Michal Lučanský on 25.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit



class GameOverSceneSpaceInvaders: SKScene{

    private var playAgainLabel = SKLabelNode()
    private var backToMenu = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        
        playAgainLabel = self.childNode(withName: "PlayAgainLabel") as! SKLabelNode
        backToMenu = self.childNode(withName: "BackToMenu") as! SKLabelNode
       

        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            
            
            
            if let touchName = atPoint(location).name{
                
                
                
                
                switch touchName {
                    
                case "PlayAgainLabel":
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = SpaceInvadersClass(fileNamed: "SpaceInvadersScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            
                            // Present the scene
                            view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                        }
                        
                        
                    }
                case "BackToMenu" :
                    if let view = self.view {
                        if let scene = MainMenu(fileNamed: "MainMenu") {
                            scene.scaleMode = .aspectFill
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
