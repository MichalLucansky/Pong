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
    let worldSizeWidth = 720
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
    
  
    private var foodCount = 0
    private var snake = [SKSpriteNode]()
private var lastUpdateTime: CFTimeInterval = 0
    
    private var timeSinceLastMove: CFTimeInterval  = 0  // Seconds since the last move
    private enum SnakeDirection{
        
        case left
        case right
        case down
        case up
        case none
        
        
        
    }
    
    
    override func didMove(to view: SKView) {
       
        left = (childNode(withName: "Left") as? SKSpriteNode)!
        right = (childNode(withName: "Right") as? SKSpriteNode)!
        down = (childNode(withName: "Down") as? SKSpriteNode)!
        up = (childNode(withName: "Up") as? SKSpriteNode)!
        border = (childNode(withName: "Border") as? SKSpriteNode)!
        snake.append(createSnakeHead())
    rowsAndCollumnNumber()
       
        
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
                    
                    
                default:
                    break
                }
                
                
                
                
                
            }
            
            
        }
    }
    
    private func rowsAndCollumnNumber()-> (Int, Int){
    
    let rowsPozitive = Int(1000 / 40 )//Int(self.frame.height / 40)

    let collumnsPozitive = Int(720 / 40) //Int(self.frame.width / 40)
  
    print(rowsPozitive, collumnsPozitive)
    
        return (rowsPozitive, collumnsPozitive)
    
    }
    
    private func createSnakeHead()-> SKSpriteNode{
        let texture = SKTexture(imageNamed: String(format: "Image-1.png"))
        let scale = CGSize(width: 80, height: 80)
        let snakeHead = SKSpriteNode()
        snakeHead.size.height = 40
        snakeHead.size.width = 40
        snakeHead.position = CGPoint(x: 0, y: 167)
        snakeHead.name = "SnakeHead"
        snakeHead.color = UIColor.brown
        snakeHead.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snakeHead.zPosition = 0
        snakeHead.texture = texture
        snakeHead.scale(to: scale)
        snakeHead.zRotation = CGFloat(M_PI)
        
        
        self.addChild(snakeHead)
        
       
        
        return snakeHead

    
    
    }
   
    private func snakeTransition(snakeHead: SKNode){
        
        let maxX = CGFloat(worldSizeWidth / 2)//self.frame.size.width / 2
        let minX = CGFloat(worldSizeWidth / -2)//self.frame.size.width / -2
        let maxY = CGFloat(worldSizeHeight / 2 + 167)//self.frame.size.height / 2
        let minY = CGFloat(worldSizeHeight / -2 + 185)//self.frame.size.height / -2
        
        if snakeHead.position.x > maxX{
            snakeHead.position.x = minX
        }else if snakeHead.position.x < minX{
            snakeHead.position.x = maxX
        }else if snakeHead.position.y > maxY{
            snakeHead.position.y = minY
        }else if snakeHead.position.y < minY{
            snakeHead.position.y = maxY
        }
        
        
        
        
        
    }
    private func snakeMove(moveX: CGFloat, moveY: CGFloat){
        
        
    snake[0].position.x = snake[0].position.x + moveX
    snake[0].position.y = snake[0].position.y + moveY
    snake[0].zRotation = rotation
        print(rotation)
    }
    
    func randomNumberGenerator(start: Int, end: Int) -> CGFloat{
        
        let x = Int(arc4random_uniform(UInt32(end - start + 1))) + start
        
        
        return CGFloat(x)
        
        
        
        
        
        
    }

    private func createFood() -> SKSpriteNode{
        
        
        let maxX = rowsAndCollumnNumber().1 / 2
        let minX = rowsAndCollumnNumber().1 / -2

        let maxY = rowsAndCollumnNumber().0 / 2
        let minY = rowsAndCollumnNumber().0 / -3
        
        
        
        let  positionX = randomNumberGenerator(start: Int(minX) , end: Int(maxX))
        let  positionY = randomNumberGenerator(start: Int(minY) , end: Int(maxY))
        

        let food = SKSpriteNode()
        food.size.height = 40
        food.size.width = 40
        food.position = CGPoint(x: positionX * 40, y: positionY * 40)
        food.name = "Food"
        food.color = UIColor.green
        food.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        food.zPosition = 0
        
       print(food.position)
        
        
        
        
        return food
        
        
        
        
    }
    
    private func createdBodyPart() -> SKSpriteNode{
        
      
        let texture = SKTexture(imageNamed: String(format: "body.png"))
        let last:SKSpriteNode = snake[snake.count-1]
        
        let lastX = last.position.x + offsetX
        let lastY = last.position.y + offsetY
        let scale = CGSize(width: 70, height: 70)
       let body = SKSpriteNode()
      
        body.size.height = 40
        body.size.width = 40
        body.position = CGPoint(x: lastX  , y : lastY )
        body.name = "Body"
        body.color = UIColor.blue
        body.anchorPoint = CGPoint(x: 0.5 , y: 0.5)
        body.zPosition = 0
        body.texture = texture
        body.scale(to: scale)
        addChild(body)
        
        return body
        
        
        
        
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
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = GameOverClass(fileNamed: "GameOverSnake") {
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
