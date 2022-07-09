//
//  ScoreVC.swift
//  BubblePop
//
//  Created by James Yu on 19/1/21.
//

import Foundation
import UIKit

class ScoreVC: UIViewController {
    
    @IBOutlet weak var rankTableView: UITableView!
    
    var sortScore = [(key: String, value: Double)]()
    var showScore = [(key: String, value: Double)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let x = UserDefaults.standard.object(forKey: "rank") as? [String : Double] {

            sortScore = x.sorted(by: {$0.value > $1.value})
            
        }
        
       
    }


}
    
    


extension ScoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortScore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "toShowCell", for: indexPath)
        let index = indexPath.row
       
        let toShowName = sortScore[index].key
        let toShowScore = sortScore[index].value
        cell.textLabel?.text = toShowName
        cell.detailTextLabel?.text = String(toShowScore)
        
        return cell
    }
    
    
}

