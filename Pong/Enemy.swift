//
//  File.swift
//  Pong
//
//  Created by Michal Lučanský on 15.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    
    
    func moveEnemy(ballPosition: SKSpriteNode, enemy: SKSpriteNode) {
        
        
        
        
        
        enemy.run(SKAction.moveTo(x: ballPosition.position.x, duration: 0.32
        ))
       

    }

    
  


}
