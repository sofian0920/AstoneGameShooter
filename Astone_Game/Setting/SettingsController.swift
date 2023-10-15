//
//  SerttingInteractorProtocol.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import Foundation

protocol SettingsControllerrProtocol {
    
    var view: SettingsViewProtocol? { get set }
    func vieWillAppear()
    func speedLevel()
    func setUserName(with name: String)
    func setPlainImage(with value: PlainImage)
    func present(speedLevel value: SpeedLevel)
    func present(userName value: String)
}

final class SettingsController: SettingsControllerrProtocol {
    
    // MARK: - Properties
    
    private let settings: CherecterSettingsProtocol
    internal weak var view: SettingsViewProtocol?
    
    // MARK: - Initialization
    
    init(settings: CherecterSettings) {
        self.settings = settings
    }
    
    // MARK: - SettingsControllerrProtocol Methods
    
    func present(speedLevel value: SpeedLevel) {
        view?.show(speedLevel: value.rawValue)
    }
    
    func present(userName value: String) {
        view?.show(userName: value)
    }
    
    func vieWillAppear() {
        present(speedLevel: settings.speedLevel)
        present(userName: settings.userName)
    
    }
    func speedLevel() {
        var newValue: SpeedLevel?
        switch settings.speedLevel {
        case .easy:
            newValue = .normal
        case .normal:
            newValue = .hard
        case .hard:
            newValue = .easy
        }
        settings.setSpeedLevel(with: newValue ?? .easy)
        present(speedLevel: settings.speedLevel)
       
    }
    
    func setUserName(with name: String) {
        settings.setUserName(with: name)
        present(userName: settings.userName)
    }
    
    func setPlainImage(with value: PlainImage) {
        settings.setPlainImage(with: value)
        
        
    }
    
}
