
import Foundation
import SpriteKit


struct leaderboardInfo: Codable {
    var id = UUID()
    var gameScore: Int
}

let leaderboardScore = leaderboardInfo(gameScore: points)
let leaderboardScores = [leaderboardScore]


class Leaderboard: SKScene {
    var exitButton: SKLabelNode!
    var leaderboardView: SKLabelNode!
    
        
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "SeminarRoom.png")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        self.run(SKAction.playSoundFileNamed("gameTheme.mp3", waitForCompletion: false))
        createSceneContent()
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(leaderboardScore)
            UserDefaults.standard.set(data, forKey: "LB")
        } catch {
            print("unable to encode Leaderboard \(error)")
        }
        
        if let data = UserDefaults.standard.data(forKey: "LB") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let leaderboardScores = try decoder.decode([leaderboardInfo].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }


    }
    
    func createSceneContent() {
        
//        let leadRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 500 , height: 300))
//        
//        leadRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.17))
//        leadRect.name = "Leaderboard Rectangle"
//        addChild(leadRect)
        

        leaderboardView = SKLabelNode(fontNamed: "Barcade Bold")
//        leaderboardView.text = String(leaderboardScores)
        leaderboardView.fontColor = UIColor.green

        exitButton = SKLabelNode(fontNamed: "Barcade Bold")
        exitButton.text = "Exit"
        exitButton.fontColor = UIColor.green
        exitButton.fontSize = CGFloat(frame.height * 0.05)
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
