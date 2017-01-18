//
//  SpaceInvadersClass.swift
//  Pong
//
//  Created by Michal Lučanský on 18.12.16.
//  Copyright © 2016 Michal Lučanský. All rights reserved.
//

import SpriteKit

class SpaceInvadersClass: SKScene, SKPhysicsContactDelegate {
    var backgroundMusic: SKAudioNode!
    private var shipLiveLabel = SKLabelNode()
    private var enemy = Enemy()
    private var ship = Player()
    private var shot = Player()
    private var invadersCount = 24
    private var shipLiveCount = 100
    private var shotCount = 1
    private let maxX = CGFloat(339)
    private let minX = CGFloat(-349)
   
    private var  timeOfLastMove : CFTimeInterval = 0.0
    private var  timePerMove : CFTimeInterval = 0.8
    private var invaderMovementDirection: InvaderMoveDirection = .right
    
    
    private let shipFiredBullet = "shipFiredBullet"
    private let invaderFiredBullet = "invaderFiredBullet"
    private let bulletSize = CGSize(width:4, height:8)
    
    
    private enum BulletType{
        case shipFiredBullet
        case invaderFiredBullet
        
    }
    
    private enum InvaderMoveDirection {
        case left
        case right
        case downRight
        case downLeft
        case none
        
    }
    
    override func didMove(to view: SKView) {
        
        initialization()
        self.physicsWorld.contactDelegate = self
        if let musicURL = Bundle.main.url(forResource: "01 A Night Of Dizzy Spells", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }


        
    }
    
    private func bulletCreator(bulletType: BulletType)-> SKSpriteNode{
    
        var bullet = SKSpriteNode()
        let shipBulletcategoryMask : UInt32 = 0x1 << 2
        let shipBulletcollisionMask : UInt32 = 0x1 << 1
        let shipBulletcontaktMask : UInt32 = 0x1 << 0
        let invaderBulletcategoryMask : UInt32 = 0x1 << 1
        let invaderBulletcollisionMask : UInt32 = 0x1 << 2
        let invaderBulletcontaktMask : UInt32 = 0x1 << 0
        
        switch bulletType {
        case .shipFiredBullet:
            bullet = SKSpriteNode(color: SKColor.green, size: bulletSize)
            bullet.name = shipFiredBullet
            bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 4, height: 8))
            bullet.physicsBody?.isDynamic = true
            bullet.physicsBody?.affectedByGravity = false
            bullet.physicsBody?.categoryBitMask = shipBulletcategoryMask
            bullet.physicsBody?.collisionBitMask = shipBulletcollisionMask
            bullet.physicsBody?.contactTestBitMask = shipBulletcontaktMask

        case.invaderFiredBullet:
            
            bullet = SKSpriteNode(color: SKColor.red, size: bulletSize)
            bullet.name = invaderFiredBullet
           
            bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 4, height: 8))
            bullet.physicsBody?.isDynamic = true
            bullet.physicsBody?.affectedByGravity = false
            bullet.physicsBody?.categoryBitMask = invaderBulletcategoryMask
            bullet.physicsBody?.collisionBitMask = invaderBulletcollisionMask
            bullet.physicsBody?.contactTestBitMask = invaderBulletcontaktMask
        
        }
    
    
    
    return bullet
    }
    
    private func fireBullet(bullet: SKNode, destination: CGPoint, duration: CFTimeInterval){
        let bulletFired = SKAction.sequence([SKAction.move(to: destination, duration: duration),SKAction.wait(forDuration: 3.0 / 60.0),SKAction.removeFromParent()])
        bullet.run(SKAction.group([bulletFired]))
        addChild(bullet)
    }
    
    
    
    private func invaderFired(forUpdate: CFTimeInterval){
        let existingBullet = childNode(withName: invaderFiredBullet )
        
        if existingBullet == nil {
        
        var invaderArray = [SKNode]()
            
            enumerateChildNodes(withName: "invaders"){
            node, stop in
                invaderArray.append(node)
            
            
            }
            if invaderArray.count > 0 {
                
                let invadersIndex = Int(arc4random_uniform(UInt32(invaderArray.count)))
                
                let chosenInvader = invaderArray[invadersIndex]
                let bullet = bulletCreator(bulletType: .invaderFiredBullet)
                bullet.position = CGPoint(x: chosenInvader.position.x, y: chosenInvader.position.y)
                
                let bulletDestination = CGPoint(x: chosenInvader.position.x, y: -600)
                
                
                fireBullet(bullet: bullet, destination: bulletDestination, duration: 2.0)
            }
        
        }
        
    
    
    }
    
    private func shipFired(){
           let existingBullet = childNode(withName: shipFiredBullet )
            
            
            if existingBullet == nil{
                if let ship = childNode(withName: "ship"){
                
                let bullet = bulletCreator(bulletType: .shipFiredBullet)
                    bullet.position = CGPoint(x: ship.position.x, y: ship.position.y)
                    
                    let bulletDestination = CGPoint(x: ship.position.x, y: 650)
                    
                    shotCount = 1
                    
                    fireBullet(bullet: bullet, destination: bulletDestination, duration: 1.0)
                   self.run(SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false))
                
                }
                
            }
            
            
            
        }
        
        
        
        
    
    


   private func moveInvader(forUpdate currentTime: CFTimeInterval){
        
        
        if (currentTime - timeOfLastMove < timePerMove){
            return
                    }
    
    
    invaderMovementControl()
    
        enumerateChildNodes(withName: "invaders")
        {node, stop in
            switch self.invaderMovementDirection{
            case .right :
                node.position = CGPoint(x: node.position.x + 15, y: node.position.y)
            case . left:
                node.position = CGPoint(x: node.position.x - 30, y: node.position.y)
            case .downLeft, .downRight:
                node.position = CGPoint(x: node.position.x, y: node.position.y - 30)
                
            case.none:
                break
                
                
            }
            self.timeOfLastMove = currentTime
            
            
           
        }
        
        
    }

    private func invaderMovementControl(){
        
   
        let proposedMoveDirection: InvaderMoveDirection = invaderMovementDirection
        
    
        enumerateChildNodes(withName: "invaders")
        { node, stop in
            
            switch proposedMoveDirection{
            case.right:
                if (node.position.x >= CGFloat(320)) {
             
                    self.invaderMovementDirection = .downLeft
                    
                    stop.pointee = true
                    
                }
            case.left:
                if (node.position.x <= CGFloat(-325)){
                    
                    
                    self.invaderMovementDirection = .downRight
                    
                    stop.pointee = true

            
            }
            case.downLeft:
                self.invaderMovementDirection = .left
                stop.pointee = true
            case.downRight:
                self.invaderMovementDirection = .right
                stop.pointee = true
            
            default:
                break
        
        
        
        
        }
    
    }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
      let location = touch.location(in: self)
            
            
          
                    ship.move(touchLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if atPoint(location).name != nil{
           
                    shotCount = 0
                    
                
            }
            
            
            
                    }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            ship.move(touchLocation: location)
        }
    }

    
  
    private func initialization(){
    
        ship = childNode(withName: "ship") as! Player
        enemy = childNode(withName: "invaders") as! Enemy
        shipLiveLabel = childNode(withName: "shipLifeCount") as! SKLabelNode
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        
        
        if  nodeNames.contains(shipFiredBullet) && nodeNames.contains("invaders"){
         contact.bodyA.node!.removeFromParent()
         contact.bodyB.node!.removeFromParent()
            self.run(SKAction.playSoundFileNamed("invaderkilled.wav", waitForCompletion: false))
            shotCount = 1
            invadersCount -= 1
        
        }
        if nodeNames.contains(invaderFiredBullet) && nodeNames.contains("ship"){
            self.run(SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false))
            shipLiveCount -= 10
            shipLiveLabel.text = ("Ship live : \(shipLiveCount)")
        
        }
        
        
            }
    
    
 
    
    private func endGame(){
        
        let lowLvl = CGFloat(-400)
    
        if shipLiveCount == 0 {
     
        ship.removeFromParent()

    
            
            if let view = self.view {
                // Load the SKScene from 'GameScene.sks'
                if let scene = GameOverSceneSpaceInvaders(fileNamed: "GameOverSpaceInvaders") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                }
                
                
            }
        
       
        }
        
        if invadersCount == 0{
            
            if let view = self.view {
                // Load the SKScene from 'GameScene.sks'
                if let scene = VictoryScene(fileNamed: "VictoryScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene,transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1.5)))
                }
                
                
            }

            
            
            
            
        }
        
        enumerateChildNodes(withName: "invaders") {
         node, stop in
            if ((node.frame.minY) <= lowLvl){
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = GameOverSceneSpaceInvaders(fileNamed: "GameOverSceneSpaceInvaders") {
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
        
        self.invaderFired(forUpdate: currentTime)
        self.moveInvader(forUpdate: currentTime)
        self.endGame()
        
        
        if shotCount == 0{
           self.shipFired()

            
        }
      
        
            
        
        }
         
    
       
    
}