
import Foundation
import SpriteKit

class Intro: SKScene {
    
    var playButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "SeminarRoom.png")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        self.run(SKAction.playSoundFileNamed("gameTheme.mp3", waitForCompletion: false))
        createSceneContent()

    }
    
    func createSceneContent() {
        
        let playRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 380 , height: 180))
        
        playRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.2))

        playRect.name = "Play Rectangle"
        addChild(playRect)
        
        let textNode = SKLabelNode(fontNamed: "Helvetica Bold")
        textNode.fontColor = UIColor.yellow
        textNode.text = "Tap Santo \nTo collect Apples \nFor Santo!"
        textNode.numberOfLines = 3
        textNode.fontSize = CGFloat(frame.height * 0.05)
        textNode.horizontalAlignmentMode = .center
        textNode.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.1))
        textNode.name = "Welcome Label"
        addChild(textNode)
        
        // the play button label
        playButton = SKSpriteNode(imageNamed: "santoFace.png")
        playButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 2))
        playButton.name = "Play Label"
        addChild(playButton)
        
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
            }
        }
        
}

