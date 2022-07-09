//
//  Bubble.swift
//  BubblePop
//
//  Created by James Yu on 16/1/21.
//

import UIKit

class Bubble: UIButton {

    var point: Double = 0
    var radius = UInt32(UIScreen.main.bounds.width / 13)
       
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = CGFloat(radius)
        
        let colorChance = Int.random(in: 0..<100)
        if colorChance < 40 {
            self.backgroundColor = .red
            self.point = 1 }
        else if colorChance < 70 && colorChance > 39 {
            self.backgroundColor = .magenta
            self.point = 2 }
        else if colorChance < 85 && colorChance > 69 {
            self.backgroundColor = .green
            self.point = 5 }
        else if colorChance < 95 && colorChance > 84 {
            self.backgroundColor = .blue
            self.point = 8 }
        else if colorChance > 94 {
            self.backgroundColor = .black
            self.point = 10 }
            
        }
        
    func animation() {
        let bubbleAnimation = CASpringAnimation(keyPath: "transform.scale")
        bubbleAnimation.fromValue = 0
        bubbleAnimation.toValue = 1
        bubbleAnimation.initialVelocity = 1
        bubbleAnimation.damping = 8
        bubbleAnimation.duration = 2
        layer.add(bubbleAnimation, forKey: nil)
    }
}

