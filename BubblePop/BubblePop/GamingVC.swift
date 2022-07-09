//
//  GamingVC.swift
//  BubblePop
//
//  Created by James Yu on 14/1/21.
//

import UIKit

class GamingVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var maxNumber: UILabel!
    

    var name:String = ""
    var remainTime = 60
    var maxBubble = 15
    var timer = Timer()
    var totalScore:Double = 0
    var lastTouch:Double = 0
    var bubble = Bubble()
    var currentBubble = [Bubble]()
    var playerScore : Dictionary = [String : Double]()
    var historyScore : Dictionary = [String : Double]()
    
    
    var screenWidth = UInt32(UIScreen.main.bounds.width)
    var screenHeight = UInt32(UIScreen.main.bounds.height)
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        name = defaults.string(forKey: "PlayerName")!
        nameLabel.text = name
        timerLabel.text = String(remainTime)
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.count()
            self.popBubble()
            self.bubbleDisappear()
        }
        
        if let historyScore = UserDefaults.standard.dictionary(forKey: "rank") as? [String:Double]  {
                playerScore = historyScore
            
        }
        
            
    }
    @objc func count() {
            remainTime -= 1
            timerLabel.text = String(remainTime)
            
            if remainTime == 0 {
                timer.invalidate()
                self.perform(#selector(endingAlert), with: nil)
                self.perform(#selector(saveScore))
            }
        }
    
    @objc func popBubble() {
        let toPop = Int.random(in: 1...maxBubble - currentBubble.count + 1)
        var m = 0
        while m < toPop {
            bubble = Bubble()
            bubble.frame = CGRect(x: CGFloat(10 + arc4random_uniform(screenWidth - 2 * bubble.radius - 10)), y: CGFloat(160 + arc4random_uniform(screenHeight - (2 * bubble.radius) - 180)), width: CGFloat(bubble.radius * 2), height: CGFloat(bubble.radius * 2))
            bubble.addTarget(self, action: #selector(tapBubble), for: .touchUpInside)
            if nonOverlap(newBubble: bubble) {
                self.view.addSubview(bubble)
                bubble.animation()
                m += 1
                currentBubble += [bubble]
            }
        }
    }
    @IBAction func tapBubble(_ sender: Bubble) {
           sender.removeFromSuperview()
           lastTouch = sender.point
           if lastTouch == sender.point {
               totalScore += sender.point * 1.5
           } else {
               totalScore += sender.point
           }
           scoreLabel.text = "\(totalScore)"
       
       }
    
    @objc func bubbleDisappear() {
        var m = 0
        while  m < currentBubble.count {
            if Int.random(in: 0...10) < 6 {
                currentBubble[m].removeFromSuperview()
                currentBubble.remove(at: m)
                m += 1
                }
            }
            
    }
        
        
        
    func nonOverlap(newBubble: Bubble) -> Bool {
        for oldBubble in currentBubble {
            if newBubble.frame.intersects(oldBubble.frame) {
                return false
            }
        }
        return true
    }
    
    @objc func saveScore() {
        if playerScore.keys.contains(name) == false {
            playerScore.updateValue(totalScore, forKey: name)
            UserDefaults.standard.set(playerScore, forKey: "rank")
        } else {
            if playerScore[name]! <= totalScore {
                playerScore.updateValue(totalScore, forKey: name)
                UserDefaults.standard.set(playerScore, forKey: "rank")
            }
        }
        
        }

    @objc func endingAlert() {
        let alert = UIAlertController(title: "Time Up", message: "Congualtions! Your score is \(totalScore)", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
        
                        
        alert.addAction(UIAlertAction(title: "Ranking", style: UIAlertAction.Style.default, handler:{ action in self.gameToScore()}))
        
        self.present(alert, animated: true, completion: nil)
    }
    func gameToScore() {
        performSegue(withIdentifier: "gameToScore", sender: Any?.self)
    }
   
    
    
}
