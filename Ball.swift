//
//  Ball.swift
//  Pong
//
//  Created by Michal Lučanský on 16.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit


class Ball: SKSpriteNode{
    
   

    
    func ballMove (ball:SKSpriteNode, speedX: CGFloat, speedY: CGFloat){
        
        
        ball.physicsBody?.applyImpulse(CGVector(dx: speedX, dy: speedY))
        
        
        
    }
    
    
    
    
    
    
}
