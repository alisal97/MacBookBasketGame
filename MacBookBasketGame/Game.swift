
import Foundation
import SpriteKit
import GameplayKit


class Game: SKScene, SKPhysicsContactDelegate {
    
    var points: Int = 0
    var basket: SKSpriteNode!
    var ground: SKSpriteNode!
    var pointsLabel: SKLabelNode!
    var seminarRoom: SKSpriteNode!
    var randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    var fruitTextures: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        seminarRoom = SKSpriteNode(imageNamed: "SeminarRoom.png")
        seminarRoom.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(seminarRoom)
        physicsWorld.contactDelegate = self
        let backgroundMusic = SKAudioNode(fileNamed: "gameplay.mp3")
        backgroundMusic.autoplayLooped = true
        backgroundMusic.isPositional = false
        backgroundMusic.run(SKAction.changeVolume(to: 0.15, duration: 0))
        self.addChild(backgroundMusic)
        createSceneContent()
    }
    
    func createSceneContent() {
        ground = SKSpriteNode(color: UIColor(red: (0 / 255.0), green: (0 / 255.0), blue: (0 / 255.0), alpha: 1.0), size: CGSize(width: frame.width, height: frame.height * 0.05))
        let groundBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.position = CGPoint(x: frame.width / 2.0, y: 0.0)
        groundBody.isDynamic = false
        groundBody.affectedByGravity = false
        ground.physicsBody = groundBody
        ground.name = "Ground"
        addChild(ground)
        
        let basketTexture = SKTexture(imageNamed: "Player.png")
        basket = SKSpriteNode(texture: basketTexture)
        basket.position = CGPoint(x: frame.midX, y: frame.minY + 0.05 * frame.height)
        let basketBody = SKPhysicsBody(rectangleOf: basket.size)
        basketBody.isDynamic = false
        basketBody.affectedByGravity = false
        basketBody.usesPreciseCollisionDetection = true
        basket.physicsBody = basketBody
        basket.name = "Basket"
        addChild(basket)
        let xConstraint = SKConstraint.positionX(SKRange(lowerLimit: basket.size.width / 2, upperLimit: frame.width - (basket.size.width / 2)))
        basket.constraints = [xConstraint]
        
        let apple1 = SKTexture(imageNamed: "apple1.png")
        let apple2 = SKTexture(imageNamed: "apple2.png")
        let apple3 = SKTexture(imageNamed: "apple3.png")
        
        fruitTextures = [apple1, apple2, apple3]
        
        let scoreRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 150 , height: 38))
        
        scoreRect.position = CGPoint(x: frame.maxX - (size.width * 0.2), y: frame.maxY - (size.height * 0.1))

        scoreRect.name = "Score Rectangle"
        addChild(scoreRect)

        pointsLabel = SKLabelNode(fontNamed: "Helvetica Bold")
        pointsLabel.numberOfLines = 3
        pointsLabel.text = "\(points) Apples"
        pointsLabel.fontColor = UIColor.yellow
        pointsLabel.fontSize = CGFloat(frame.height * 0.04)
        pointsLabel.position = CGPoint(x: frame.maxX - (size.width * 0.2), y: frame.maxY - (size.height * 0.125))
        pointsLabel.name = "Points Label"
        addChild(pointsLabel)
    }
     
    override func update(_ currentTime: TimeInterval) {
        let choice = randomSource.nextUniform()
        if (choice < 0.02) {
            let x = CGFloat(randomSource.nextUniform()) * frame.width
            let y = frame.height
            addFruit(at: CGPoint(x: x, y: y))
        }
    }
   
    func addFruit(at location: CGPoint) {
        let random = Int(randomSource.nextUniform() * 5.0)
        let fruitChoice = random % fruitTextures.count
        let specApple = fruitTextures[0]
        let fruitTexture = fruitTextures[fruitChoice]
        let SpecialApple = SKSpriteNode(texture: specApple)
        let fruit = SKSpriteNode(texture: fruitTexture)
        fruit.position = location
        let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 0.5, height: 0.5))
        SpecialApple.name = "Rainbow"
        fruitBody.isDynamic = true
        fruitBody.affectedByGravity = false
        fruitBody.contactTestBitMask = 0xffffffff
        fruit.physicsBody = fruitBody
        fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: 3.5)))
        fruit.name = "Fruit"
        addChild(fruit)
        
        
    }



    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        
                if (nameA == "Basket" && nameB == "Rainbow") {
                    nodeB.run(SKAction.removeFromParent())
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    pointsLabel.text = String(points + 2)
                    points += 2
                    winningPoints()
                    losingPoints()
                }
                
                else if (nameB == "Basket" && nameA == "Rainbow") {
                    nodeA.run(SKAction.removeFromParent())
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    pointsLabel.text = String(points + 2)
                    points += 2
                    winningPoints()
                    losingPoints()
                }
                else if (nameA == "Basket" && nameB == "Fruit") {
                    nodeB.run(SKAction.removeFromParent())
                    pointsLabel.text = String(points + 1)
                    points += 1
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    winningPoints()
                    losingPoints()
                }
                else if (nameB == "Basket" && nameA == "Fruit") {
                    nodeA.run(SKAction.removeFromParent())
                    pointsLabel.text = String(points + 1)
                    points += 1
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    winningPoints()
                    losingPoints()
                }
                else if (nameA == "Ground" && nameB == "Fruit") {
                    nodeB.run(SKAction.removeFromParent())
                    pointsLabel.text = String(points - 1)
                    points -= 1
                    winningPoints()
                    losingPoints()
                }
                else if (nameB == "Ground" && nameA == "Fruit") {
                    nodeA.run(SKAction.removeFromParent())
                    pointsLabel.text = String(points - 1)
                    points -= 1
                    winningPoints()
                    losingPoints()
                }
                
            }

    func losingPoints() {
        if (points <= -3) {
            if let view = view {
                let gameOver = gameover(size: size)
                let transition = SKTransition.fade(withDuration: 3.0)
                view.presentScene(gameOver, transition: transition)
            }
        }
    }

    func winningPoints() {
        if (points >= 31) {
            if let view = view {
                let outro = Outro(size: size)
                let transition = SKTransition.fade(withDuration: 3.0)
                view.presentScene(outro, transition: transition)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let increment = CGFloat(frame.width * 0.01)
        let duration = 0.0
        let events = event?.allTouches
        let touchEvent = events?.first
        let touchLocation = touchEvent?.location(in: self)
        let location = CGPoint(x: touchLocation!.x, y: touchLocation!.y)
        if (location.x > frame.midX) {
            let action = SKAction.moveBy(x: increment, y: 0, duration: duration)
            action.timingMode = .easeInEaseOut
            basket.run(action)
        }
        else {
            let action = SKAction.moveBy(x: -increment, y: 0, duration: duration)
            action.timingMode = .easeInEaseOut
            basket.run(action)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let increment = CGFloat(frame.width * 0.01)
        let duration = 0.1
        let events = event?.allTouches
        let touchEvent = events?.first
        let touchLocation = touchEvent?.location(in: self)
        let location = CGPoint(x: touchLocation!.x, y: touchLocation!.y)
        if (location.x > frame.midX) {
            let action = SKAction.moveBy(x: increment, y: 0, duration: duration)
            action.timingMode = .easeInEaseOut
            basket.run(action)
        
        }
        else {
            let action = SKAction.moveBy(x: -increment, y: 0, duration: duration)
            action.timingMode = .easeInEaseOut
            basket.run(action)
        }
    }
}


