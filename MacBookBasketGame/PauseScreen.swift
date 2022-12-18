//
//  PauseScreen.swift
//  MacBookBasketGame
//
//  Created by Aly Salman on 15/12/22.
//

import Foundation
import SpriteKit

class PauseScreen: SKScene {
    
    var unPause: SKLabelNode!
    var exitButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "SeminarRoom.png")
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        createSceneContent()
    }
    
    func createSceneContent() {

        let rectangle = SKSpriteNode(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.75), size: CGSize(width: frame.maxX, height: frame.maxY))
        rectangle.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        rectangle.name = "Rectangle"
        addChild(rectangle)
        
        
        unPause = SKLabelNode(fontNamed: "Barcade Bold")
        unPause.text = "Continue"
        unPause.fontSize = CGFloat(frame.height * 0.05)
        unPause.fontColor = UIColor.green
        unPause.position = CGPoint(x: size.width / 2.0, y: (size.height / 2))
        unPause.name = "Unpause Button"
        addChild(unPause)
        
        exitButton = SKLabelNode(fontNamed: "Barcade Bold")
        exitButton.text = "Exit"
        exitButton.fontSize = CGFloat(frame.height * 0.05)
        exitButton.fontColor = UIColor.green
        exitButton.position = CGPoint(x: size.width / 2.0, y: (size.height / 3))
        exitButton.name = "Exit Button"
        addChild(exitButton)

        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let name = atPoint(touchLocation).name
            if name == "Unpause Button" {
                if let view = view {
                    let game = Game(size: size)
                    isPaused = false
                    let transition = SKTransition.fade(withDuration: 0)
                    view.presentScene(game, transition: transition)
                    }
            }
                else if name == "Exit Button" {
                        if let view = view {
                            points = 0
                            lives = 3
                            let exit = Intro(size: size)
                            let transition = SKTransition.fade(withDuration: 1.0)
                            view.presentScene(exit, transition: transition)

                        }
                    
                }
        }
      
            }
        }
        


