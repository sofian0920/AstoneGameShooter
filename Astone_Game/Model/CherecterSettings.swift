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
    case userImage
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
    
    // MARK: - CherecterSettingsProtocol Conformance
    
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
    
    var userImage: UIImage {
        guard let imageName = UserDefaults.standard.value(forKey: Keys.userImage.rawValue) as? String else {
            let image = Image.userImage.wrappedValue
            return image ?? UIImage()
        }
        let image = getUserImage(with: imageName)
        return image ?? UIImage()
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
    
    func setUserImage(with image: UIImage) {
        let nameImage = saveImage(image: image)
        UserDefaults.standard.set(nameImage, forKey: Keys.userImage.rawValue)
    }
    
    func getUserImage(with name: String) -> UIImage? {
        loadImage(fileName: name)
    }
    
    // MARK: - Private Utility Methods
    
    private func getDocumentsDirectory() -> URL? {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        }
        
        private func generateUniqueFileName() -> String {
            return UUID().uuidString
        }
    
    private func saveImage(image: UIImage) -> String? {
        guard let documentDirectory = getDocumentsDirectory() else { return nil }
        
        let fileName = generateUniqueFileName()
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                return nil
            }
        }
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            return nil
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        guard let documentsDirectory = getDocumentsDirectory() else { return nil }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        return UIImage(contentsOfFile: fileURL.path)
    }
}

