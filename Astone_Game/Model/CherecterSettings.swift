//
//  CherecterSettings.swift
//  Astone_Game
//
//  Created by Софья Норина on 7.10.2023.
//

import Foundation
import UIKit


enum PlainImage: String {
    case plainOne
    case plainTwo
    case plainThree
}

enum Keys: String {
    case plainImage
    case speedLevel
    case gameScores
    case scoresCount
    case userName
}


enum SpeedLevel: String{
    case easy
    case normal
    case hard
    
    var speed: Double {
        switch self{
        case .easy:
            return 5
        case .normal:
            return 3
        case .hard:
            return 2
        }
    }
}

protocol CherecterSettingsProtocol {
    var plainImage: UIImage { get }
    var userName: String { get }
    var speedLevel: SpeedLevel { get }
    
    func setplainImage(with plainImage: PlainImage)
    func setUserName(with name: String)
}


class CherecterSettings: CherecterSettingsProtocol {
   
    static let settingElement = CherecterSettings()
    
    var userName: String {
        guard let name = UserDefaults.standard.value(forKey: Keys.userName.rawValue) as? String else { return "" }
        return name
    }
    
    var plainImage: UIImage{
        let plainImage = UserDefaults.standard.value(forKey: Keys.plainImage.rawValue) as? String
        let image = UIImage(named: plainImage ?? PlainImage.plainOne.rawValue)
        return image ?? UIImage()
    }
    
    var speedLevel: SpeedLevel {
        let value = UserDefaults.standard.value(forKey: Keys.speedLevel.rawValue) as? String
        return SpeedLevel(rawValue: value ?? "") ?? .easy
    }
    
    var score: [String] {
        guard let array = UserDefaults.standard.value(forKey: Keys.scoresCount.rawValue) as? [String] else {
            return []
        }
        return array
    }
    
    func setplainImage(with plainImage: PlainImage) {
        UserDefaults.standard.set(plainImage.rawValue, forKey: Keys.plainImage.rawValue)
    }
    
    func setUserName(with name: String) {
        UserDefaults.standard.set(name, forKey: Keys.userName.rawValue)
    }
    
    func setSpeedLevel(with level: SpeedLevel) {
        UserDefaults.standard.set(level.rawValue, forKey: Keys.speedLevel.rawValue)
    }
    
    func writeScore(_ value: String) {
        guard var array = UserDefaults.standard.value(forKey: Keys.gameScores.rawValue) as? [String] else {
            let array = [value]
            UserDefaults.standard.set(array, forKey: Keys.gameScores.rawValue)
            return
        }
        array.append(value)
        UserDefaults.standard.set(array, forKey: Keys.gameScores.rawValue)
        
    }
}
