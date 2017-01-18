//
//  BlockBreakerClass.swift
//  Pong
//
//  Created by Michal Lučanský on 18.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit

class BlockBreaker: SKScene, SKPhysicsContactDelegate{
    
    var backgroundMusic: SKAudioNode!
    private var playerPadle = Player()
    private var ball = Ball()
    private var brick = SKSpriteNode()
    private var score = Int()
    private var obstacle = Utilities()
    
    
    
    override func didMove(to view: SKView) {
        
        
     
        initialization()
       
        ball.ballMove(ball: ball)
        if let musicURL = Bundle.main.url(forResource: "03 Chibi Ninja", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }

        
    }
    
    
     private func addObstacle(){
        
        let height = obstacle.randomNumberGenerator()
        let width = obstacle.randomNumberGenerator()
        self.addChild(obstacle.randomSpriteGenerator(height: height, width: width, position: CGPoint(x: -400, y: 150)))
        
        
    }
    
    private func initialization(){
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
        
        
       
  
        playerPadle = childNode(withName: "Player") as! Player
        ball = childNode(withName: "ball") as! Ball
        
            }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            playerPadle.move(touchLocation: location)

        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            playerPadle.move(touchLocation: location)
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "ball" && bodyBName == "brick" || bodyAName == "brick" && bodyBName! == "ball"{
            if bodyAName == "brick"{
                contact.bodyA.node?.removeFromParent()
                score += 1
                
            }else if  bodyBName == "brick"{
                contact.bodyB.node?.removeFromParent()
                score += 1
            }
        }    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
      
        
      
           
            
        
      
        
        
        if ball.position.y < playerPadle.position.y {
            
            if let view = self.view {
                // Load the SKScene from 'GameOverScene'
                if let scene = BlockBreakerGameOver(fileNamed: "BlockBreakerGameOver") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                    
                    
                }
                
            }
            
            
        }
        
        if score == 9{
            
            if let view = self.view {
                // Load the SKScene from 'GameOverScene'
                if let scene = NextLvlClass(fileNamed: "NextLvlScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                    
                    
                }
                
            }

            
        }
    
        
    }
    
    
}
