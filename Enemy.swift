//
//  File.swift
//  Pong
//
//  Created by Michal Lučanský on 15.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    
    
    func moveEnemy(ballPosition: SKSpriteNode, enemy: SKSpriteNode, duration: Double) {
        
        
        
        
        
        enemy.run(SKAction.moveTo(x: ballPosition.position.x, duration: duration
            
        ))
       

    }

    
  


}
