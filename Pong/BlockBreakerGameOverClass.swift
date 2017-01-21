//
//  BlockBreakerGameOverClass.swift
//  Pong
//
//  Created by Michal Lučanský on 18.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit


class BlockBreakerGameOver: SKScene {
    
    private var highScore = UserDefaults.standard
    private var highScoreLabel = SKLabelNode()
    private var playAgainLabel = SKLabelNode()
    private var backToMenu = SKLabelNode()
    private var lvlStatus = BlockBreaker.nextLvlInit
    private var actualScore = Int()
    private var gameId = UserDefaults.standard
    
    override func didMove(to view: SKView) {
       
        
        let id = gameId.integer(forKey: "ID")
        print(id)
        if id == 1{
            actualScore = highScore.integer(forKey: "highScore")
        
        }else if id == 2{
            actualScore = highScore.integer(forKey: "SpaceInvaders")
        
        
        
        }
       // actualScore = highScore.integer(forKey: "highScore")
        highScoreLabel = self.childNode(withName: "highScore") as! SKLabelNode
        playAgainLabel = self.childNode(withName: "PlayAgainLabel") as! SKLabelNode
        backToMenu = self.childNode(withName: "BackToMenu") as! SKLabelNode
        highScoreLabel.text = "\(actualScore)"
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            
            
            if let touchName = atPoint(location).name{
                
                
                
                
                switch touchName {
                    
                case "PlayAgainLabel":
                    BlockBreaker.nextLvlInit = false
                    if let view = self.view {
                        
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = BlockBreaker(fileNamed: "BlockBreakerScene") {
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
