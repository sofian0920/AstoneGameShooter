//
//  File.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import Foundation


protocol SettingPresenterProtocol {
    func present(speedLevel value: SpeedLevel)
    func present(userName value: String)
}

final class SettingPresenter: SettingPresenterProtocol {
    weak var view: SettingsViewController?
    
    func present(speedLevel value: SpeedLevel) {
//        view?.show(speedLevel: value.rawValue)
    }
    
    func present(userName value: String) {
//        view?.show(userName: value)
    }
    
    
}
//final class SettingsPresenter: SettingsPresenterProtocol {
//    weak var view: SettingsViewProtocol?
//    
//    func present(difficultyLevel value: DifficultyLevel) {
//        view?.show(difficultyLevel: value.rawValue)
//    }
//    
//    func present(controlMode value: ControlMode) {
//        view?.show(controlMode: value.rawValue)
//    }
//    
//    func present(userName value: String) {
//        view?.show(userName: value)
//    }
//    
//}
