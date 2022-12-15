
import Foundation
import SpriteKit
import GameplayKit

var totalApples: Int = 0
var points: Int = 0



class Game: SKScene, SKPhysicsContactDelegate {
    
    var lives: Int = 3
    var basket: SKSpriteNode!
    var animation: SKTexture!
    var ground: SKSpriteNode!
    var pointsLabel: SKLabelNode!
    var livesLabel: SKLabelNode!
    var seminarRoom: SKSpriteNode!
    var randomSource = GKLinearCongruentialRandomSource.sharedRandom()
    var randomSourceSpec = GKLinearCongruentialRandomSource.sharedRandom()
    var fruitTextures: [SKTexture] = []
    var arrows: SKSpriteNode!


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
        ground = SKSpriteNode(color: UIColor(red: (0 / 255.0), green: (0 / 255.0), blue: (0 / 255.0), alpha: 1.0), size: CGSize(width: frame.width, height: frame.height * 0.21))
        let groundBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.position = CGPoint(x: frame.width / 2.0, y: 0.19)
        groundBody.isDynamic = false
        groundBody.affectedByGravity = false
        ground.physicsBody = groundBody
        ground.name = "Ground"
        addChild(ground)
        
        let basketTexture = SKTexture(imageNamed: "Player.png")
        basket = SKSpriteNode(texture: basketTexture)
        basket.position = CGPoint(x: frame.midX, y: frame.minY + 0.157 * frame.height)
        let basketBody = SKPhysicsBody(rectangleOf: basket.size)
        basketBody.isDynamic = false
        basketBody.affectedByGravity = false
        basketBody.usesPreciseCollisionDetection = true
        basket.physicsBody = basketBody
        basket.name = "Basket"
        addChild(basket)
        let xConstraint = SKConstraint.positionX(SKRange(lowerLimit: basket.size.width / 2, upperLimit: frame.width - (basket.size.width / 2)))
        basket.constraints = [xConstraint]
        
        animation = SKTexture(imageNamed: "Animation.png")
        
        let arrowTextures = SKTexture(imageNamed: "arrows.png")
        arrows = SKSpriteNode(texture: arrowTextures)
        arrows.position = basket.position
        arrows.physicsBody?.isDynamic = true
        arrows.name = "Arrows"
        addChild(arrows)
        

        
        let apple1 = SKTexture(imageNamed: "apple1.png")
        let apple2 = SKTexture(imageNamed: "apple2.png")
        let apple3 = SKTexture(imageNamed: "apple3.png")
        
        fruitTextures = [apple1, apple2, apple3]

        pointsLabel = SKLabelNode(fontNamed: "Barcade No Bar Bold")
        pointsLabel.numberOfLines = 3
        pointsLabel.text = "Collected: \(points)"
        pointsLabel.fontColor = UIColor.green
        pointsLabel.fontSize = CGFloat(frame.height * 0.023)
        pointsLabel.position = CGPoint(x: frame.maxX - (size.width * 0.2), y: frame.maxY - (size.height * 0.123))
        pointsLabel.name = "Points Label"
        addChild(pointsLabel)
        
        livesLabel = SKLabelNode(fontNamed: "Barcade No Bar Bold")
        livesLabel.numberOfLines = 3
        livesLabel.text = "Lives: \(lives) ❤️"
        livesLabel.fontColor = UIColor.green
        livesLabel.fontSize = CGFloat(frame.height * 0.03)
        livesLabel.position = CGPoint(x: size.width * 0.2, y: frame.maxY - (size.height * 0.123))
        livesLabel.name = "Lives Label"
        addChild(livesLabel)
    }
//    override func didApplyConstraints() -> Void {
//        Game().scene?.view?.isPaused = true
//    }

    override func update(_ currentTime: TimeInterval) {
        
        guard !Game().isPaused else { return }

        let choice = randomSource.nextUniform()
        if (choice <= 0.0175) {
            let x = CGFloat(randomSource.nextUniform()) * frame.width
            let y = frame.height
            addFruit(at: CGPoint(x: x, y: y))
            
        }
        else if ( choice <= 0.0213) && (choice >= 0.0195) {
            let xSpec = CGFloat(randomSource.nextUniform()) * frame.width
            let ySpec = frame.height
            addSpecial(at:CGPoint(x: xSpec, y: ySpec))
        }
    }


    func addFruit(at location: CGPoint) {
        if points <= 10 {
            let random = Int(randomSource.nextUniform() * 9)
            let spawnTime = Double.random(in: 1.5...1.7 )
            let fruitChoice = random % fruitTextures.count
            let fruitTexture = fruitTextures[fruitChoice]
            let fruit = SKSpriteNode(texture: fruitTexture)
            fruit.position = location
            let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
            fruitBody.isDynamic = true
            fruitBody.affectedByGravity = false
            fruitBody.contactTestBitMask = 0xffffffff
            fruit.physicsBody = fruitBody
            fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
            fruit.name = "Fruit"
            addChild(fruit)
        }
        else if points >= 10 {
            let random = Int(randomSource.nextUniform() * 9.9)
            let spawnTime = Double.random(in: 1.1...1.3)
            let fruitChoice = random % fruitTextures.count
            let fruitTexture = fruitTextures[fruitChoice]
            let fruit = SKSpriteNode(texture: fruitTexture)
            fruit.position = location
            let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
            fruitBody.isDynamic = true
            fruitBody.affectedByGravity = false
            fruitBody.contactTestBitMask = 0xffffffff
            fruit.physicsBody = fruitBody
            fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
            fruit.name = "Fruit"
            addChild(fruit)
        }

       else if points >= 15 {
           let random = Int(randomSource.nextUniform() * 11)
           let spawnTime = Double.random(in: 0.7...0.9)
           let fruitChoice = random % fruitTextures.count
           let fruitTexture = fruitTextures[fruitChoice]
           let fruit = SKSpriteNode(texture: fruitTexture)
           fruit.position = location
           let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
           fruitBody.isDynamic = true
           fruitBody.affectedByGravity = false
           fruitBody.contactTestBitMask = 0xffffffff
           fruit.physicsBody = fruitBody
           fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
           fruit.name = "Fruit"
           addChild(fruit)
        }
        else if points >= 20 {
            let random = Int(randomSource.nextUniform() * 13)
            let spawnTime = Double.random(in: 0.3...0.5)
            let fruitChoice = random % fruitTextures.count
            let fruitTexture = fruitTextures[fruitChoice]
            let fruit = SKSpriteNode(texture: fruitTexture)
            fruit.position = location
            let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
            fruitBody.isDynamic = true
            fruitBody.affectedByGravity = false
            fruitBody.contactTestBitMask = 0xffffffff
            fruit.physicsBody = fruitBody
            fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
            fruit.name = "Fruit"
            addChild(fruit)
        }
        else if points >= 25 {
            let random = Int(randomSource.nextUniform() * 15)
            let spawnTime = Double.random(in: 0.05...0.1)
            let fruitChoice = random % fruitTextures.count
            let fruitTexture = fruitTextures[fruitChoice]
            let fruit = SKSpriteNode(texture: fruitTexture)
            fruit.position = location
            let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
            fruitBody.isDynamic = true
            fruitBody.affectedByGravity = false
            fruitBody.contactTestBitMask = 0xffffffff
            fruit.physicsBody = fruitBody
            fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
            fruit.name = "Fruit"
            addChild(fruit)
        }
        else if points >= 35 {
            let random = Int(randomSource.nextUniform() * 15)
            let spawnTime = Double.random(in: 0.01...0.03)
            let fruitChoice = random % fruitTextures.count
            let fruitTexture = fruitTextures[fruitChoice]
            let fruit = SKSpriteNode(texture: fruitTexture)
            fruit.position = location
            let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
            fruitBody.isDynamic = true
            fruitBody.affectedByGravity = false
            fruitBody.contactTestBitMask = 0xffffffff
            fruit.physicsBody = fruitBody
            fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
            fruit.name = "Fruit"
            addChild(fruit)
        }
        else if points >= 50 {
            let random = Int(randomSource.nextUniform() * 15)
            let spawnTime = Double.random(in: 0.005...0.0095)
            let fruitChoice = random % fruitTextures.count
            let fruitTexture = fruitTextures[fruitChoice]
            let fruit = SKSpriteNode(texture: fruitTexture)
            fruit.position = location
            let fruitBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
            fruitBody.isDynamic = true
            fruitBody.affectedByGravity = false
            fruitBody.contactTestBitMask = 0xffffffff
            fruit.physicsBody = fruitBody
            fruit.run(SKAction.move(to: CGPoint(x: fruit.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
            fruit.name = "Fruit"
            addChild(fruit)
        }
        


    }

    func addSpecial(at location: CGPoint) {
        let specApple = SKTexture(imageNamed: "rainbowApple.png")
        let SpecialApple = SKSpriteNode(texture: specApple)
        let spawnTime = Double.random(in: 2.3...3.5)
        let specAppleBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 1))
        SpecialApple.position = location
        SpecialApple.physicsBody = specAppleBody
        specAppleBody.isDynamic = true
        specAppleBody.affectedByGravity = false
        specAppleBody.contactTestBitMask = 0xffffffff
        SpecialApple.run(SKAction.move(to: CGPoint(x: SpecialApple.position.x, y: 10.0), duration: TimeInterval(floatLiteral: spawnTime)))
        SpecialApple.name = "Rainbow"
        addChild(SpecialApple)

        
    }


    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        
                if (nameA == "Basket" && nameB == "Rainbow") {
                    nodeB.run(SKAction.removeFromParent())
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    pointsLabel.text = String("Collected: \(points + 3)")
                    points += 3
                    totalApples += 3
                    let aniAction = SKAction.setTexture(animation)
                    let aniTime = SKAction.wait(forDuration: 0.19)
                    let aniRevert = SKAction.setTexture(SKTexture(imageNamed: "Player.png"))
                    let aniSeq = SKAction.sequence([aniAction,aniTime,aniRevert])
                    basket.run(aniSeq)

                }
                else if (nameB == "Basket" && nameA == "Rainbow") {
                    nodeA.run(SKAction.removeFromParent())
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    pointsLabel.text = String("Collected: \(points + 3)")
                    points += 3
                    totalApples += 3
                    let aniAction = SKAction.setTexture(animation)
                    let aniTime = SKAction.wait(forDuration: 0.19)
                    let aniRevert = SKAction.setTexture(SKTexture(imageNamed: "Player.png"))
                    let aniSeq = SKAction.sequence([aniAction,aniTime,aniRevert])
                    basket.run(aniSeq)

                }
                else if (nameA == "Basket" && nameB == "Fruit") {
                    nodeB.run(SKAction.removeFromParent())
                    pointsLabel.text = String("Collected: \(points + 1)")
                    points += 1
                    totalApples += 1
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    let aniAction = SKAction.setTexture(animation)
                    let aniTime = SKAction.wait(forDuration: 0.19)
                    let aniRevert = SKAction.setTexture(SKTexture(imageNamed: "Player.png"))
                    let aniSeq = SKAction.sequence([aniAction,aniTime,aniRevert])
                    basket.run(aniSeq)

                }
                else if (nameB == "Basket" && nameA == "Fruit") {
                    nodeA.run(SKAction.removeFromParent())
                    pointsLabel.text = String("Collected: \(points + 1)")
                    points += 1
                    totalApples += 1
                    self.run(SKAction.playSoundFileNamed("appleeatsound.mp3", waitForCompletion: false))
                    let aniAction = SKAction.setTexture(animation)
                    let aniTime = SKAction.wait(forDuration: 0.19)
                    let aniRevert = SKAction.setTexture(SKTexture(imageNamed: "Player.png"))
                    let aniSeq = SKAction.sequence([aniAction,aniTime,aniRevert])
                    basket.run(aniSeq)

                }
                else if (nameA == "Ground" && nameB == "Rainbow") {
                    nodeB.run(SKAction.removeFromParent())
                    livesLabel.text = String("Lives: \(lives - 1) ❤️")
                    lives -= 1
                    liveCounter()
                }
                else if (nameB == "Ground" && nameA == "Rainbow") {
                    nodeA.run(SKAction.removeFromParent())
                    livesLabel.text = String("Lives: \(lives - 1) ❤️")
                    lives -= 1
                    liveCounter()
                }
                else if (nameA == "Ground" && nameB == "Fruit") {
                    nodeB.run(SKAction.removeFromParent())
                    livesLabel.text = String("Lives: \(lives - 1) ❤️")
                    lives -= 1
                    liveCounter()
                }
                else if (nameB == "Ground" && nameA == "Fruit") {
                    nodeA.run(SKAction.removeFromParent())
                    livesLabel.text = String("Lives: \(lives - 1) ❤️")
                    lives -= 1
                    liveCounter()
                }
                
            }

    func liveCounter() {
        if (lives == 0) && (totalApples < 1000) {
            var leaderboard : [leaderboardInfo] = decodeLeaderboard()
            leaderboard.append(leaderboardInfo(gameScore: points))
            leaderboard.sort { $0.gameScore > $1.gameScore}
            encodeLeaderboard(scores: leaderboard)
            if let view = view {
                let gameover = Gameover(size: size)
                let transition = SKTransition.fade(withDuration: 3.0)
                view.presentScene(gameover, transition: transition)
            }
            
        } else if (lives == 0) && (totalApples >= 1000) {
            var leaderboard : [leaderboardInfo] = decodeLeaderboard()
            leaderboard.append(leaderboardInfo(gameScore: points))
            leaderboard.sort { $0.gameScore > $1.gameScore}
            encodeLeaderboard(scores: leaderboard)
            if let view = view {
                let gameComp = GameComplete(size: size)
                let transition = SKTransition.fade(withDuration: 3.0)
                view.presentScene(gameComp, transition: transition)
            }
            
        }
    }


    
//    func winningPoints() {
//        if (points >= 31) {
//            if let view = view {
//                let outro = Outro(size: size)
//                let transition = SKTransition.fade(withDuration: 3.0)
//                view.presentScene(outro, transition: transition)
//            }
//        }
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.scene?.view?.isPaused = true
//
//    }
//
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.scene?.view?.isPaused = false
            arrows.run(SKAction.removeFromParent())
            let location = touch.location(in: self)
            basket.position.x = location.x
        }
        
        }

    }


