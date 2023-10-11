//
//  SelectionViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 22.09.2023.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: AnyObject{
    func show(speedLevel value: String)
    func show(userName value: String)
}

class SettingsViewController: UIViewController, SettingsViewProtocol {
    
    private let interactor: SettingInteractorProtocol
    private let backgroundImage = UIImageView()
    private let speedLevelButton = UIButton()
    private let currentSpeedLavelLabel = UILabel()
    private let plainSelectionButton = UIButton()
    private let exitButton = UIButton()
    private let userNameTextField = UITextField()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let presenter = SettingsPresenter()
        self.interactor = SettingInteractor(presenter: presenter, settings: CherecterSettings.shared)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setUpUI()
    
    }
    private func setUpUI() {
        addButton()
        addBackgroundView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.vieWillAppear()
        
    }
     
    @objc private func plainSelectionButtonTapped() {
        let viewController = SettingPlainViewController { [weak self] result in
            self?.interactor.setPlainImage(with: result)
        }
        present(viewController, animated: true)
    }
    
    @objc private func speedLavelButtonTapped() {
        interactor.speedLevel()
    }

    @objc private func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func addButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ]
        
        let speedLevelButtonAttributes = NSAttributedString(string: "SPEED LEVEL", attributes: attributes)
        speedLevelButton.setAttributedTitle(speedLevelButtonAttributes, for: .normal)
        speedLevelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speedLevelButton)
        speedLevelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        speedLevelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        speedLevelButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        speedLevelButton.heightAnchor.constraint(equalTo: speedLevelButton.widthAnchor, multiplier: 0.15).isActive = true
        speedLevelButton.addTarget(self, action: #selector(speedLavelButtonTapped), for: .touchUpInside)
        
        
        currentSpeedLavelLabel.translatesAutoresizingMaskIntoConstraints = false
        currentSpeedLavelLabel.font = .boldSystemFont(ofSize: 20)
        currentSpeedLavelLabel.textAlignment = .center
        speedLevelButton.addSubview(currentSpeedLavelLabel)
        currentSpeedLavelLabel.bottomAnchor.constraint(equalTo: speedLevelButton.bottomAnchor).isActive = true
        currentSpeedLavelLabel.widthAnchor.constraint(equalTo: speedLevelButton.widthAnchor).isActive = true
        
    
        
        let plainSelectionButtonAttributes = NSAttributedString(string: "SELECT PLAIN", attributes: attributes)
        plainSelectionButton.setAttributedTitle(plainSelectionButtonAttributes, for: .normal)
        plainSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plainSelectionButton)
        plainSelectionButton.centerXAnchor.constraint(equalTo: speedLevelButton.centerXAnchor).isActive = true
        plainSelectionButton.topAnchor.constraint(equalTo: speedLevelButton.bottomAnchor).isActive = true
        plainSelectionButton.widthAnchor.constraint(equalTo: speedLevelButton.widthAnchor).isActive = true
        plainSelectionButton.heightAnchor.constraint(equalTo: speedLevelButton.heightAnchor).isActive = true
        plainSelectionButton.addTarget(self, action: #selector(plainSelectionButtonTapped), for: .touchUpInside)
        
    
        
        let saveButtonAttributes = NSAttributedString(string: "SAVE AND EXIT", attributes: attributes)
        exitButton.setAttributedTitle(saveButtonAttributes, for: .normal)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        exitButton.centerXAnchor.constraint(equalTo: speedLevelButton.centerXAnchor).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        exitButton.widthAnchor.constraint(equalTo: speedLevelButton.widthAnchor).isActive = true
        exitButton.heightAnchor.constraint(equalTo: speedLevelButton.heightAnchor).isActive = true
        exitButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        userNameTextField.placeholder = "Enter your name"
        userNameTextField.textAlignment = .center
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.autocapitalizationType = .words
        userNameTextField.autocorrectionType = .no
        userNameTextField.delegate = self
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameTextField)
        userNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        userNameTextField.widthAnchor.constraint(equalTo: speedLevelButton.widthAnchor).isActive = true
        userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func addBackgroundView() {
        backgroundImage.image = Image.background.wrappedValue
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.layoutIfNeeded()
    }

    
    func show(speedLevel value: String) {
        DispatchQueue.main.async {
            self.currentSpeedLavelLabel.text = "Current speed: \(value)"
        }
    }
    
    func show(userName value: String) {
        userNameTextField.text = value
    }
}


extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userNameTextField.resignFirstResponder()
            interactor.setUserName(with: textField.text ?? "")
        }
        return true
    }
}

