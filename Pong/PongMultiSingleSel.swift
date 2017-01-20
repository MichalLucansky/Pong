//
//  P.swift
//  Pong
//
//  Created by Michal Lučanský on 18.1.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import SpriteKit


class PongMultiSingleSel:SKScene{

var backgroundMusic: SKAudioNode!
    private var multiPlay = SKLabelNode()
    private var single = SKLabelNode()
    static var statusInit = Bool()
    
    override func didMove(to view: SKView) {
        multiPlay = childNode(withName: "MULTIPLAYER") as! SKLabelNode
        single = childNode(withName: "SINGLEPLAYER") as! SKLabelNode
        if let musicURL = Bundle.main.url(forResource: "08 Ascending", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
        let position = touch.location(in: self)
            
            if let touchName = atPoint(position).name {
            
                switch touchName {
                case "MULTIPLAYER":
                    PongMultiSingleSel.statusInit = false
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = Pong(fileNamed: "PongScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                        
                            // Present the scene
                            view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                            
                        }
                        
                        
                    }
                case "SINGLEPLAYER":
                    PongMultiSingleSel.statusInit = true
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

