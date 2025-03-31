//
//  GameScene.swift
//  Breakout
//
//  Created by Rohan Patel on 3/17/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball = SKShapeNode()
    
    override func didMove(to view: SKView) {
        //this stuff happens once(when the app opens)
        createBackground()
        resetGame()
    }
    func resetGame() {
        makeBall()
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "Stars")
        for i in 0...1 {
            let starsBackgrounds = SKSpriteNode(texture: stars)
            starsBackgrounds.zPosition = -1
            starsBackgrounds.position = CGPoint(x: 0, y: starsBackgrounds.size.height * CGFloat(i))
                        addChild(starsBackgrounds)
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackgrounds.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackgrounds.size.height,duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackgrounds.run(moveForever)
            
        }
    }
    func makeBall() {
        ball.removeFromParent ()      // remove the ball (if it exists)
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .yellow
        ball.name = "ball"
        // physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        // use precise collision detection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        // no loss of energy from friction
        ball.physicsBody?.friction = 0
        // gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        // bounces fully off of other objects
        ball.physicsBody?.restitution = 1
        // does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball) // add ball object to the view
    }
}
