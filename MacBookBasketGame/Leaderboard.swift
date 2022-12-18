
import Foundation
import SpriteKit


struct leaderboardInfo: Codable {
    var id = UUID()
    var gameScore: Int
}





class Leaderboard: SKScene {
    var exitButton: SKLabelNode!
    var leaderboardView: SKLabelNode!
    let leaderboardScore = leaderboardInfo(gameScore: points)
    let leaderboardScores = decodeLeaderboard()
        
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "SeminarRoom.png")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        self.run(SKAction.playSoundFileNamed("gameTheme.mp3", waitForCompletion: false))
        
        let rectangle = SKSpriteNode(color: UIColor(red: 25/255, green: 0/255, blue: 25/255, alpha: 0.59), size: CGSize(width: frame.maxX, height: frame.maxY))
        rectangle.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        rectangle.name = "Rectangle"
        addChild(rectangle)

        
        
        var i: Int = 1
        for e in leaderboardScores {
            let element = SKLabelNode()
            element.position = CGPoint(x: size.width/2, y: size.height * (0.90 - CGFloat(i)*0.05))
            element.text = "\(String(i))                        \(String(e.gameScore))"
            element.fontSize = 37
            element.fontName = "Barcade Bold"
            element.fontColor = UIColor.green
            i+=1
            if i > 11 {
                break
            } else {
                addChild(element)
            }
        }
        createSceneContent()

        
            }
    func createSceneContent() {
        
//        let leadRect = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), size: CGSize(width: 500 , height: 300))
//        
//        leadRect.position = CGPoint(x: (size.width / 2.0), y: (size.height / 2) + (size.height * 0.17))
//        leadRect.name = "Leaderboard Rectangle"
//        addChild(leadRect)
        


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

func decodeLeaderboard() -> [leaderboardInfo]{
    if let data = UserDefaults.standard.data(forKey: "LB") {
        do {
            // Create JSON Decoder
            let decoder = JSONDecoder()
            
            // Decode Note
            let leaderboardScores = try decoder.decode([leaderboardInfo].self, from: data)
            return leaderboardScores
        } catch {
            print("Unable to Decode Notes (\(error))")
        }
    }
    return []
}

func encodeLeaderboard(scores : [leaderboardInfo]){
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(scores)
        UserDefaults.standard.set(data, forKey: "LB")
    } catch {
        print("unable to encode Leaderboard \(error)")
    }
}
