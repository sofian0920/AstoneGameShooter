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
            return 5.0
        case .normal:
            return 3.0
        case .hard:
            return 2.0
        }
    }
}

protocol CherecterSettingsProtocol {
    var plainImage: UIImage { get }
    var userName: String { get }
    var speedLevel: SpeedLevel { get }
    
    func setPlainImage(with plainImage: PlainImage)
    func setUserName(with name: String)
    func setSpeedLevel(with level: SpeedLevel)
    func writeScore(with value: String)
}


class CherecterSettings: CherecterSettingsProtocol {
   
    static let shared = CherecterSettings()
    
    private init() {}
    
    var userName: String {
        return UserDefaults.standard.string(forKey: Keys.userName.rawValue) ?? ""
    }
    
    var plainImage: UIImage{
        let imageName = UserDefaults.standard.string(forKey: Keys.plainImage.rawValue) ?? PlainImage.plainOne.rawValue
        return UIImage(named: imageName) ?? UIImage()
    }
    
    var speedLevel: SpeedLevel {
        let value = UserDefaults.standard.value(forKey: Keys.speedLevel.rawValue) as? String
        return SpeedLevel(rawValue: value ?? "") ?? .easy
    }
    
    var score: [String] {
        return UserDefaults.standard.stringArray(forKey: Keys.scoresCount.rawValue) ?? []
    }
    
    func setPlainImage(with plainImage: PlainImage) {
        UserDefaults.standard.set(plainImage.rawValue, forKey: Keys.plainImage.rawValue)
    }
    
    func setUserName(with name: String) {
        UserDefaults.standard.set(name, forKey: Keys.userName.rawValue)
    }
    
    func setSpeedLevel(with level: SpeedLevel) {
        UserDefaults.standard.set(level.rawValue, forKey: Keys.speedLevel.rawValue)
    }
    
    func writeScore(with value: String) {
        var score = self.score
        score.append(value)
        UserDefaults.standard.set(score, forKey: Keys.scoresCount.rawValue)
    }
}
