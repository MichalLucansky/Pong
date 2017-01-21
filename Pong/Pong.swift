//
//  GameScene.swift
//  Pong
//
//  Created by Michal Lučanský on 15.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit
import GameplayKit

class Pong: SKScene {
    var backgroundMusic: SKAudioNode!
    private var player = Player()
    private var secondPlayer = Enemy()
    private var enemy = Enemy()
    private var ball = Ball()
    private var gamePauseEnd = SKLabelNode()
    private var endGame = SKLabelNode()
    private var pause = SKLabelNode()
    private var enemyScoreLabel = SKLabelNode()
    private var playerScoreLabel = SKLabelNode()
    private var center = CGFloat()
    private var enemyScore = 0
    private var playerScore = 0
    private var pauseVariable = Utilities()
    private var pauseStatus = false
    private var status  = PongMultiSingleSel.statusInit
    private var selectedNodes:[UITouch:SKSpriteNode] = [:]
    
    override func didMove(to view: SKView) {
        
        initialization()
        ball.ballMove(ball: ball, speedX: -15, speedY: 15)
        if let musicURL = Bundle.main.url(forResource: "02 HHavok-main", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
           
        }

    }
    
   

    // initialization of all sprites
    private func initialization(){
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
       
        player = childNode(withName: "Player") as! Player
        enemy = childNode(withName: "Enemy") as! Enemy
        ball = childNode(withName: "Ball") as! Ball
        
        enemyScoreLabel = childNode(withName: "EnemyScore") as! SKLabelNode
        enemyScoreLabel.text = ("UI Player : \(enemyScore)")
        playerScoreLabel = childNode(withName: "PlayerScoreLabel") as! SKLabelNode
        playerScoreLabel.text = ("Player : \(playerScore)")
        endGame = childNode(withName: "ENDGAME") as! SKLabelNode
        pause = childNode(withName: "Pause") as! SKLabelNode
        gamePauseEnd = childNode(withName: "GAMEISPAUSED") as! SKLabelNode
        gamePauseEnd.isHidden = true
        
    }
    
    
    
    //
    private func checkPointStatus(playerWhoWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == player {
            playerScore += 1
            playerScoreLabel.text = ("Player : \(playerScore)")
            ball.physicsBody?.applyImpulse(CGVector(dx: -15, dy: -15))
            
        }
        if playerWhoWon == enemy {
            enemyScore += 1
            enemyScoreLabel.text = ("UI Player : \(enemyScore)")
            ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
        }
        
        
        
        
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
   
            
            if let node = selectedNodes[touch] {
                node.position.x = location.x
                let minX : CGFloat = -260, maxX: CGFloat = 260
                
                position.x = node.position.x
                if position.x > maxX{
                    position.x = maxX
                }
                if position.x < minX{
                    position.x = minX
                }
            }
            
            
        }
    }
    


    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches{
            let location = touch.location(in: self)
           
            
            if let node = self.atPoint(location) as? SKSpriteNode{
                if node.name == "Player" || node.name == "Enemy"{
                selectedNodes[touch] = node
                
                }
            
            
            }
            
            if let touchName = atPoint(location).name{
                
                switch touchName {
                    
                case "ENDGAME":
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = EndGameLost(fileNamed: "EndGameLost") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            
                            // Present the scene
                            view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                            
                        }
                    }
                    
                case "Pause":
                                     pauseStatus = true
                    pause.isHidden = true
                    gamePauseEnd.isHidden = false
                   
                    
                  case "GAMEISPAUSED":
                  
                    
                    pauseStatus = false
                    pause.isHidden = false
                    gamePauseEnd.isHidden = true

                   
                    
                    
                    
                default:
                    break
                    
                }
                
            }

            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if selectedNodes[touch] != nil {
                selectedNodes[touch] = nil
            }
        }
    }
    
    func gamePause(){
        
        
        
        
        
        self.physicsWorld.speed = 0
        
        
        
    }
    func gameUnPause(){
        
        
        
        
        self.physicsWorld.speed = 1
        
        
        
    }

 
    override func update(_ currentTime: TimeInterval) {
        
        if pauseStatus == true {
            gamePause()
            
        }else if pauseStatus == false{
        gameUnPause()
        }
        
        if status {
        
        enemy.moveEnemy(ballPosition: ball, enemy: enemy)
        }
        
        if ball.position.y > enemy.position.y{
            checkPointStatus(playerWhoWon: player)
            
        }
        
        if ball.position.y < player.position.y{
            checkPointStatus(playerWhoWon: enemy)
        }
        
        if enemyScore == 10{
            
            
                
                if let view = self.view {
                    // Load the SKScene from 'GameOverScene'
                    if let scene = EndGameLost(fileNamed: "EndGameLost") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1.5)))
                        
                        
                    }
                    
                }
            }
         
        if playerScore == 10{
          
                
                if let view = self.view {
                    // Load the SKScene from 'WinningSceneClass'
                    if let scene = WinningSceneClass(fileNamed: "WinningScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1.5)))
                        
                        
                    }
                    
                }
            }

        
        
        
        
    }


    
    





}
