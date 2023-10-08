//
//  EnemyView.swift
//  Astone_Game
//
//  Created by Софья Норина on 6.10.2023.
//

import UIKit

class EnemyView: UIImageView {
    
    private let selfAnimationDuration = 0.5
    private let selfAnimationRepeatCount = 1
    
    
    convenience init(){
        self.init(image: Image.enemy.wrappedValue)
        self.animationImages = [Image.boomFirst.wrappedValue!, Image.boomSecond.wrappedValue!]
        self.animationDuration = selfAnimationDuration
        self.animationRepeatCount = selfAnimationRepeatCount
        
    }
}
