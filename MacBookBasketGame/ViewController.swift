
import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        
        let intro = Intro(size: size)
        
        if let view = view as? SKView {
            view.presentScene(intro)
        }
    }
    
}

