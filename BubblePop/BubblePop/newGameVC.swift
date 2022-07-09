//
//  newGameVC.swift
//  BubblePop
//
//  Created by James Yu on 14/1/21.
//

import Foundation
import UIKit

class newGameVC: UIViewController {


    @IBOutlet weak var timeNum: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var bubbleSlider: UISlider!
    @IBOutlet weak var bubbleNum: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeSlider.value = 60
        bubbleSlider.value = 15
        }
   
    @IBAction func timeSlider(_ sender: Any) {
        timeNum.text = String(Int(timeSlider.value))
    }
    
    @IBAction func bubbleSlider(_ sender: Any) {
        bubbleNum.text = String(Int(bubbleSlider.value))
    }
    
  
    @IBAction func startGame(_ sender: Any) {
        if let name = nameTextField.text {
            if (name.count > 0) {
                let defaults = UserDefaults.standard
                defaults.set(name, forKey:"PlayerName")
                self.performSegue(withIdentifier: "startGameSegue", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            let newGame = segue.destination as! GamingVC
            newGame.remainTime = Int(timeSlider.value)
            newGame.maxBubble = Int(bubbleSlider.value)
        }
    }
        
   
}
    
    



