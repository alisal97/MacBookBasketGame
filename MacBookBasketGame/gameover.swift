

import Foundation
import SpriteKit

class gameover: SKScene {
    
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
        let playRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 380 , height: 130))
        
        playRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.17))

        playRect.name = "Play again Rectangle"
        addChild(playRect)

        let textNode = SKLabelNode(fontNamed: "Helvetica Bold")
        textNode.fontColor = UIColor.yellow
        textNode.text = "GAME OVER!! \nSanto is ANGRY!. \nTap Santo to try AGAIN!."
        textNode.numberOfLines = 3
        textNode.fontSize = CGFloat(frame.height * 0.0333)
        textNode.horizontalAlignmentMode = .center
        textNode.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.1))
        textNode.name = "Welcome Label"
        addChild(textNode)
        
        playButton = SKSpriteNode(imageNamed: "Santo.png")
        playButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 2))
        playButton.name = "Play Label"
        addChild(playButton)
        
        
        let leadRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 300 , height: 55))
        
        leadRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 5.5) + (size.height * 0.17))
        leadRect.name = "Leaderboard Rectangle"
        addChild(leadRect)
        
        leaderboardButton = SKLabelNode(fontNamed: "Helvetica Bold")
        leaderboardButton.text = "Open Leaderboard"
        leaderboardButton.fontColor = UIColor.yellow
        leaderboardButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 3))
        addChild(leaderboardButton)

        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let events = event?.allTouches
        let touchEvent = events?.first
        let touchLocation = touchEvent?.location(in: self)
        let location = CGPoint(x: touchLocation!.x, y: touchLocation!.y)
        if playButton.contains(location) {
            if let view = view {
                let game = Game(size: size)
                let transition = SKTransition.fade(withDuration: 1.0)
                view.presentScene(game, transition: transition)
                }
            else if leaderboardButton.contains(location) {
                    if let view = view {
                        let leaderBoard = Leaderboard(size: size)
                        let transition = SKTransition.fade(withDuration: 1.0)
                        view.presentScene(leaderBoard, transition: transition)

                    }
                }
            }
            }
        }
        


