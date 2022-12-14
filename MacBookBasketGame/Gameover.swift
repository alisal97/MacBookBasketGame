

import Foundation
import SpriteKit

class Gameover: SKScene {
    
    var playButton: SKSpriteNode!
    var leaderboardButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "SeminarRoom.png")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        self.run(SKAction.playSoundFileNamed("gameTheme.mp3", waitForCompletion: false))
        createSceneContent()

    }
    
    func createSceneContent() {
        
        let rectangle = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.75), size: CGSize(width: frame.maxX, height: frame.maxY))
        rectangle.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        rectangle.name = "Rectangle"
        addChild(rectangle)


        let textNode = SKLabelNode(fontNamed: "Barcade No Bar Bold")
        textNode.fontColor = UIColor.green
        textNode.text = "YOUR SCORE IS \(String(points))!! \nGAME OVER!! \nSanto is ANGRY!. \nTap Santo to try AGAIN!."
        textNode.numberOfLines = 3
        textNode.fontSize = CGFloat(frame.height * 0.0379)
        textNode.horizontalAlignmentMode = .center
        textNode.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.1))
        textNode.name = "Welcome Label"
        addChild(textNode)
        
        let apples = SKLabelNode(fontNamed: "Barcade Bold")
        apples.text = "SAP Coins: \(totalApples)"
        apples.fontColor = UIColor.green
        apples.fontSize = CGFloat(frame.height * 0.049)
        apples.verticalAlignmentMode = .bottom
        apples.position = CGPoint(x: (size.width / 2.0), y: (size.height / 8) + (size.height * 0.1))
        apples.name = "Apples"
        addChild(apples)
        
        playButton = SKSpriteNode(imageNamed: "Santo.png")
        playButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 2))
        playButton.name = "Play Button"
        addChild(playButton)
        
        let scoreNode = SKLabelNode(fontNamed: "Barcade No Bar Bold")
        scoreNode.fontColor = UIColor.green
        scoreNode.text = ("Final Score: \(points)")
        scoreNode.fontSize = CGFloat(frame.height * 0.039)
        scoreNode.position = CGPoint(x: frame.midX ,y: frame.midY * 1.7)
        addChild(scoreNode)
        
//
//        let leadRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 300 , height: 55))
//
//        leadRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 5.5) + (size.height * 0.17))
//        leadRect.name = "Leaderboard Rectangle"
//        addChild(leadRect)
//
        leaderboardButton = SKLabelNode(fontNamed: "Barcade Bold")
        leaderboardButton.text = "Leaderboard"
        leaderboardButton.fontSize = CGFloat(frame.height * 0.05)
        leaderboardButton.fontColor = UIColor.green
        leaderboardButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 3))
        leaderboardButton.name = "Leaderboard Button"
        addChild(leaderboardButton)

        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let name = atPoint(touchLocation).name
            if name == "Play Button" {
                if let view = view {
                    points = 0
                    lives = 3
                    let game = Game(size: size)
                    let transition = SKTransition.fade(withDuration: 1.0)
                    view.presentScene(game, transition: transition)
                    }
            }
                else if name == "Leaderboard Button" {
                        if let view = view {
                            let leaderBoard = Leaderboard(size: size)
                            let transition = SKTransition.fade(withDuration: 1.0)
                            view.presentScene(leaderBoard, transition: transition)

                        }
                    
                }
        }
      
            }
        }
        


