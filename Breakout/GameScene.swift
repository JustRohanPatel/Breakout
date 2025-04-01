//
//  GameScene.swift
//  Breakout
//
//  Created by Rohan Patel on 3/17/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball = SKShapeNode()
    var paddle = SKSpriteNode()
    var brick = SKSpriteNode()
    var loseZone = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        //this stuff happens once(when the app opens)
        createBackground()
        resetGame()
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        kickBall()
    }
    func resetGame() {
        makeBall()
        makePaddle()
        makeBrick()
    }
    func kickBall() {
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 5))
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
    func makePaddle() {
    paddle.removeFromParent() // remove the paddle, if it exists
        paddle = SKSpriteNode(color: .white, size: CGSize(width: frame.width/4, height: 20))
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
    paddle.name = "paddle"
    paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
    paddle.physicsBody?.isDynamic = false
    addChild(paddle)
    }
    func makeBrick() {
        brick.removeFromParent()
        brick = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
        brick.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    func makeLoseZone() {
        loseZone = SKSpriteNode(color: .red, size: CGSize(width: frame.width, height: 50))
        loseZone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
        loseZone.name = "loseZone"
        loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
        loseZone.physicsBody?.isDynamic = false
        addChild(loseZone)
    }
}
