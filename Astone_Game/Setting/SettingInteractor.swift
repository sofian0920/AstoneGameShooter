//
//  SerttingInteractorProtocol.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import Foundation

protocol SettingInteractorProtocol {
    func vieWillAppear()
    func speedLevel()
    func setUserName(with name: String)
    func setPlainImage(with value: PlainImage)
}

final class SettingInteractor: SettingInteractorProtocol {
    private let presenter: SettingsPresenterProtocol
    private let settings: CherecterSettingsProtocol
    
    init(presenter: SettingsPresenter, settings: CherecterSettings) {
        self.presenter = presenter
        self.settings = settings
    }
    func vieWillAppear() {
        presenter.present(speedLevel: settings.speedLevel)
        presenter.present(userName: settings.userName)
    
    }
    
    func speedLevel() {
        var newValue: SpeedLevel?
        switch settings.speedLevel {
        case .easy:
            newValue = .easy
        case .normal:
            newValue = .normal
        case .hard:
            newValue = .hard
        }
        settings.setSpeedLevel(with: newValue ?? .easy)
        presenter.present(speedLevel: settings.speedLevel)
       
    }
    
    func setUserName(with name: String) {
        settings.setUserName(with: name)
        presenter.present(userName: settings.userName)
    }
    
    func setPlainImage(with value: PlainImage) {
        settings.setPlainImage(with: value)
    }
}

