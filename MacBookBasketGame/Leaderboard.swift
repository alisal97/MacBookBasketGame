
import Foundation
import SpriteKit

class Leaderboard: SKScene {
    var exitButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "SeminarRoom.png")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        self.run(SKAction.playSoundFileNamed("gameTheme.mp3", waitForCompletion: false))
        createSceneContent()
    }
    
    func createSceneContent() {
        
        let leadRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 500 , height: 300))
        
        leadRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.17))
        leadRect.name = "Leaderboard Rectangle"
        addChild(leadRect)
        
        exitButton = SKLabelNode(fontNamed: "Helvetica Bold")
        exitButton.text = "Exit"
        exitButton.fontColor = UIColor.yellow
        exitButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 5))
        addChild(exitButton)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let events = event?.allTouches
        let touchEvent = events?.first
        let touchLocation = touchEvent?.location(in: self)
        let location = CGPoint(x: touchLocation!.x, y: touchLocation!.y)
        if exitButton.contains(location) {
            if let view = view {
                let intro = Intro(size: size)
                let transition = SKTransition.fade(withDuration: 1.0)
                view.presentScene(intro, transition: transition)
            }
            
        }
    }
}
