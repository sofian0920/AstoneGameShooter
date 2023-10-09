//
//  File.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import Foundation


protocol SettingsPresenterProtocol {
    func present(speedLevel value: SpeedLevel)
    func present(userName value: String)
}

final class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    
    func present(speedLevel value: SpeedLevel) {
        view?.show(speedLevel: value.rawValue)
    }
    
    func present(userName value: String) {
        view?.show(userName: value)
    }
    
    
}
