//
//  GameComplete.swift
//  MacBookBasketGame
// easter egg for game completion
//  Created by Aly Salman on 14/12/22.
//

import Foundation
import SpriteKit

class GameComplete: SKScene {
    
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


        let textNode = SKLabelNode(fontNamed: "Barcade No Bar Bold")
        textNode.fontColor = UIColor.green
        textNode.text = "\(String(totalApples)) SAP COINS COLLECTED!! \nSanto is HAPPY \nHe now can eat and grow hair!. \nTap Santo to play more!."
        textNode.numberOfLines = 3
        textNode.fontSize = CGFloat(frame.height * 0.0295)
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
        
        playButton = SKSpriteNode(imageNamed: "santoFace.png")
        playButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 2))
        playButton.name = "Play Santo"
        addChild(playButton)
        
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
            if name == "Play Santo" {
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
        


