//
//  Utilities.swift
//  Pong
//
//  Created by Michal Lučanský on 17.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit

class Utilities: SKScene {
    
    
   
    func randomSpriteGenerator(height: CGFloat, width: CGFloat, position: CGPoint) -> SKSpriteNode{
    
        let obstacle = SKSpriteNode()
        obstacle.size.height = height
        obstacle.size.width = width
        obstacle.position = position
        obstacle.name = "Obstacle"
        obstacle.color = UIColor.blue
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        obstacle.run(SKAction.moveTo(x: 600, duration: 10))
        
        
        
        
    
    
    
    
    
    return obstacle
    }
    
    func randomNumberGenerator ()-> CGFloat{
        var randomNumber = CGFloat()
       
        
        randomNumber = CGFloat(arc4random_uniform(UInt32(300)))
        
      return randomNumber
        
    }
    
    
        
    
     func gamePause(){
        
        
        
        
        
        self.physicsWorld.speed = 0
        
        
        
    }
     func gameUnPause(){
        
        
        
        
        self.physicsWorld.speed = 1
        
        
        
    }
    
    
    
        
    
        
    
    
    
    
    
    
}
