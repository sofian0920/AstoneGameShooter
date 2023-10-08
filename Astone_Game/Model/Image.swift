//
//  Model.swift
//  Astone_Game
//
//  Created by Софья Норина on 22.09.2023.
//

import Foundation
import UIKit

@propertyWrapper

enum Image {
    case enemy
    case border
    case userPlain
    case background
    
    var wrappedValue: UIImage? {
        switch self {
        case .enemy:
            return UIImage(named: "enemyImage")
        case .border:
            return UIImage(named: "borderImage")
        case .userPlain:
            return UIImage(named: "plainImage")
        case .background:
            return UIImage(named: "backgroundImage")
            
        }
    }
}
