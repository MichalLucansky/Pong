//
//  P.swift
//  Pong
//
//  Created by Michal Lučanský on 18.1.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import SpriteKit


class PongMultiSingleSel:SKScene{


    private var multiPlay = SKLabelNode()
    private var single = SKLabelNode()
    static var statusInit = Bool()
    
    override func didMove(to view: SKView) {
        multiPlay = childNode(withName: "MULTIPLAYER") as! SKLabelNode
        single = childNode(withName: "SINGLEPLAYER") as! SKLabelNode
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
        let position = touch.location(in: self)
            
            if let touchName = atPoint(position).name {
            
                switch touchName {
                case "MULTIPLAYER":
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = Pong(fileNamed: "PongScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            PongMultiSingleSel.statusInit = true
                            // Present the scene
                            view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                            
                        }
                        
                        
                    }
                case "SINGLEPLAYER":
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = Pong(fileNamed: "PongScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                          PongMultiSingleSel.statusInit = false
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

