//
//  GameScene.swift
//  SnakeTest
//
//  Created by Michal Lučanský on 9.1.17.
//  Copyright © 2017 Michal Lučanský. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    let worldSizeHeight = 1000
    let worldSizeWidth = 800
    var rotation = CGFloat()
    var left = SKNode()
    var right = SKNode()
    var down = SKNode()
    var up = SKNode()
    var border = SKNode()
    private var snakeDirection : SnakeDirection = .none
    var offsetX = CGFloat(0)
    var offsetY = CGFloat(0)
    var xSpeed = CGFloat(0)
    var ySpeed = CGFloat(0)
    private var pauseLabel = SKLabelNode()
    private var unpauseLabele = SKLabelNode()
    private var foodTexturesArray = [SKTexture]()
    private var scoreLabel = SKLabelNode()
    private var gameId = UserDefaults.standard
    private var foodCount = 0
    private var snake = [SKSpriteNode]()
    private var lastUpdateTime: CFTimeInterval = 0
    private var score = 0
    private var snakeScore = UserDefaults.standard
    private var timeSinceLastMove: CFTimeInterval  = 0  // Seconds since the last move
    var backgroundMusic: SKAudioNode!
    private var soundStatus = UserDefaults.standard
    
    private enum SnakeDirection{
        
        case left
        case right
        case down
        case up
        case none
        
        
        
    }
    
    
    override func didMove(to view: SKView) {
        if soundStatus.bool(forKey: "SOUNDSTATUS"){
            if let musicURL = Bundle.main.url(forResource: "02 HHavok-main", withExtension: "mp3") {
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic)
                
                
            }
        }
        
        if self.snakeScore.value(forKey: "Snake") == nil{
            snakeScore.set(score, forKey: "Snake")
            
        }
        
        
        foodTexturesArray = [SKTexture(imageNamed: String(format: "apple.png")),
                             SKTexture(imageNamed: String(format: "cherry.png")),
                             SKTexture(imageNamed: String(format: "orange.png")),
                             SKTexture(imageNamed: String(format: "strawbery.png"))
                            ]
        scoreLabel = (childNode(withName: "Score") as? SKLabelNode)!
        pauseLabel = (childNode(withName: "Pause") as? SKLabelNode)!
        unpauseLabele = (childNode(withName: "Unpause") as? SKLabelNode)!
        left = (childNode(withName: "Left") as? SKSpriteNode)!
        right = (childNode(withName: "Right") as? SKSpriteNode)!
        down = (childNode(withName: "Down") as? SKSpriteNode)!
        up = (childNode(withName: "Up") as? SKSpriteNode)!
        border = (childNode(withName: "Border") as? SKSpriteNode)!
        snake.append(createSnakeHead())
   
       
        
           }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if let touchLocation = atPoint(location).name{
                switch touchLocation {
                case "Left":
                    xSpeed = CGFloat(-40)
                    ySpeed = CGFloat(0)
                    snakeDirection = .left
                    rotation = CGFloat(M_PI_2) * -1
                    offsetX = 40
                    offsetY = 0
                  
                    
                    childNode(withName: "Right")?.isHidden = true
                    childNode(withName: "Down")?.isHidden = false
                    childNode(withName: "Up")?.isHidden = false
                    
                    
                case "Right":
                    xSpeed = CGFloat(40)
                    ySpeed = CGFloat(0)
                    snakeDirection = .right
                    rotation = CGFloat(M_PI_2)
                    offsetX = -40
                    offsetY = 0
                    
                    
                    childNode(withName: "Left")?.isHidden = true
                    childNode(withName: "Down")?.isHidden = false
                    childNode(withName: "Up")?.isHidden = false
                    
                case "Down":
                    ySpeed = CGFloat(-40)
                    xSpeed = CGFloat(0)
                    snakeDirection = .down
                    
                    offsetY = 40
                    offsetX = 0
                    rotation = CGFloat(M_PI) * 2
                    
                    childNode(withName: "Up")?.isHidden = true
                    
                    childNode(withName: "Right")?.isHidden = false
                    childNode(withName: "Left")?.isHidden = false
                case "Up":
                    ySpeed = CGFloat(40)
                    xSpeed = CGFloat(0)
                    snakeDirection = .up
                    rotation = CGFloat(M_PI)
                    offsetY = -40
                    offsetX = 0
                    childNode(withName: "Down")?.isHidden = true
                    childNode(withName: "Right")?.isHidden = false
                    childNode(withName: "Left")?.isHidden = false
                    
                case "Pause" :
                    self.scene?.isPaused = true
                    self.physicsWorld.speed = 0
                    pauseLabel.isHidden = true
                    unpauseLabele.isHidden = false
                
                case "Unpause" :
                    self.scene?.isPaused = false
                    self.physicsWorld.speed = 0
                    pauseLabel.isHidden = false
                    unpauseLabele.isHidden = true
                    
                    
                case "EndGame" :
                    
                    self.gameId.set(3, forKey: "ID")
                    if let view = self.view {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = BlockBreakerGameOver(fileNamed: "BlockBreakerGameOver") {
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
    
 
    
    private func createSnakeHead()-> SKSpriteNode{
        
        
        let texture = SKTexture(imageNamed: String(format: "Image-1.png"))
     
        let snakeHead = SKSpriteNode()
        snakeHead.size.height = 40
        snakeHead.size.width = 40
        snakeHead.position = CGPoint(x: 0, y: 0)
        snakeHead.name = "SnakeHead"
        snakeHead.color = UIColor.brown
        snakeHead.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snakeHead.zPosition = 1
        snakeHead.texture = texture
        
        
        
        
        self.addChild(snakeHead)
        
       
        
        return snakeHead

    
    
    }
   
    private func snakeTransition(snakeHead: SKNode){
        
      
        
        if snakeHead.position.x == 360 && (snakeDirection == .right){
            snakeHead.position.x = -360
        }else if snakeHead.position.x == -360 && (snakeDirection == .left){
            snakeHead.position.x = 360
        }else if snakeHead.position.y == 640 && (snakeDirection == .up){
            snakeHead.position.y = -360
        }else if snakeHead.position.y == -360 && (snakeDirection == .down){
            snakeHead.position.y = 640
        }
       
        
        
        
    }
    
    
    private func snakeMove(moveX: CGFloat, moveY: CGFloat){
        
        
    snake[0].position.x = snake[0].position.x + moveX
    snake[0].position.y = snake[0].position.y + moveY
    snake[0].zRotation = rotation
       
    }
    
    func randomNumberGenerator(start: Int, end: Int) -> CGFloat{
        
        let x = Int(arc4random_uniform(UInt32(end - start + 1))) + start
        
        
        return CGFloat(x)
        
        
        
        
        
        
    }

    private func createFood() -> SKSpriteNode{
        
        
        let maxX = 8
        let minX = -8

        let maxY = 15
        let minY = -8
        
        
        let  positionX = randomNumberGenerator(start: Int(minX) , end: Int(maxX))
        let  positionY = randomNumberGenerator(start: Int(minY) , end: Int(maxY))
        
        let randomIndex = Int(arc4random_uniform(UInt32(4)))
        let texture = foodTexturesArray[randomIndex]

        let food = SKSpriteNode()
        food.size.height = 40
        food.size.width = 40
        food.position = CGPoint(x: positionX * 40, y: positionY * 40)
        food.name = "Food"
        food.texture = texture
        food.color = UIColor.green
        food.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        food.zPosition = 0
        
               
        
        
        
        return food
        
        
        
        
    }
    
    private func createdBodyPart() -> SKSpriteNode{
        
      
        let texture = SKTexture(imageNamed: String(format: "body.png"))
        let last:SKSpriteNode = snake[snake.count-1]
        
        let lastX = last.position.x + offsetX
        let lastY = last.position.y + offsetY
        let body = SKSpriteNode()
      
        body.size.height = 40
        body.size.width = 40
        body.position = CGPoint(x: lastX  , y : lastY )
        body.name = "Body"
        body.color = UIColor.blue
        body.anchorPoint = CGPoint(x: 0.5 , y: 0.5)
        body.zPosition = 1
        body.texture = texture
       
        addChild(body)
        score += 10
        return body
        
        
        
        
    }
    
    private func foodPositionCheck() {
    
        enumerateChildNodes(withName: "Body"){
         node, _ in
            
            if node.position == self.childNode(withName: "Food")?.position{
    
                self.childNode(withName: "Food")?.removeFromParent()
                self.foodCount = 0
            
            
            }
        
        
        }
        
    
    
    
    }
    
    
    func snakeBodyMoving (){
        
        var snakeLenght = snake.count-1
  
        while snakeLenght != 0 {
            
        
        snake[snakeLenght].position.x = snake[snakeLenght-1].position.x
        snake[snakeLenght].position.y = snake[snakeLenght-1].position.y
            
                
        
            snakeLenght -= 1
            

        }
       
        
    }
    
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate: CFTimeInterval) {
   
     
        timeSinceLastMove += timeSinceLastUpdate
        
        if (timeSinceLastMove > 0.5) {
            timeSinceLastMove = 0
            
            snakeTransition(snakeHead: snake[0])
               snakeBodyMoving()
            snakeMove(moveX: xSpeed, moveY: ySpeed)
           
            if snake[0].contains((childNode(withName: "Food")?.position)!) {
                
                childNode(withName: "Food")?.removeFromParent()
                
                snake.append(createdBodyPart())
                foodCount = 0
                
            }
            
            

          
           
            
        }
            
        }
    
    private func bodyHit(){
    
        enumerateChildNodes(withName: "Body")
        {node,_ in
            
            if node.position == self.snake[0].position{
                self.gameId.set(3, forKey: "ID")
                if self.snakeScore.integer(forKey: "Snake") < self.score{
                self.snakeScore.set(self.score, forKey: "Snake")
                
                }
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = BlockBreakerGameOver(fileNamed: "BlockBreakerGameOver") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                    }
                    
                    
                }

                
                
            }

            
           
        
        
        
        
        }
    }
    
  
    

    
    
    

    
    override func update(_ currentTime: TimeInterval) {
        self.foodPositionCheck()
       
        scoreLabel.text = "SCORE: \(score) "
        var timeSinceLastUpdate = currentTime - lastUpdateTime
       
        lastUpdateTime = currentTime
        if timeSinceLastUpdate > 0.5 {
            timeSinceLastUpdate = 0.5 / 60.0
            lastUpdateTime = currentTime
        }
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
        
        if foodCount == 0{
            self.addChild(createFood())
            foodCount = 1
        }
        
        bodyHit()
    }
}
