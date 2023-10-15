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
    
    
    // MARK: - Properties
    
    private var controller: SettingsControllerrProtocol
    private let backgroundImage = UIImageView()
    private let speedLevelButton = UIButton()
    private let currentSpeedLavelLabel = UILabel()
    private let plainSelectionButton = UIButton()
    private let exitButton = UIButton()
    private let userImageButton = UIButton()
    private let userNameTextField = UITextField()
    
    
    // MARK: - Initialization
    
    init(controller: SettingsControllerrProtocol) {
            self.controller = controller
            super.init(nibName: nil, bundle: nil)
            self.controller.view = self
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setUpUI()
    
    }
    
    // MARK: - UI Setup
    
    private func setUpUI() {
        addButton()
        addBackgroundView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller.vieWillAppear()
        
    }
    
    // MARK: - Button Actions
    
    @objc private func plainSelectionButtonTapped() {
        let viewController = SettingPlainViewController { [weak self] result in
            self?.controller.setPlainImage(with: result)
        }
        present(viewController, animated: true)
    }
    
    @objc private func speedLavelButtonTapped() {
        controller.speedLevel()
    }

    @objc private func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func userImageButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
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
        
        userImageButton.setImage(CherecterSettings.shared.userImage, for: .normal)
        userImageButton.imageView?.contentMode = .scaleAspectFill
        userImageButton.backgroundColor = .clear
        userImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userImageButton)
        userImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        userImageButton.heightAnchor.constraint(equalTo: userImageButton.widthAnchor).isActive = true
        userImageButton.addTarget(self, action: #selector(userImageButtonTapped), for: .touchUpInside)
        
        userNameTextField.placeholder = "Enter your name"
        userNameTextField.textAlignment = .center
        userNameTextField.clearButtonMode = .whileEditing
        userNameTextField.autocapitalizationType = .words
        userNameTextField.autocorrectionType = .no
        userNameTextField.delegate = self
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameTextField)
        userNameTextField.topAnchor.constraint(equalTo: userImageButton.bottomAnchor).isActive = true
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

    // MARK: - SettingsViewProtocol Methods
    
    func show(speedLevel value: String) {
        DispatchQueue.main.async {
            self.currentSpeedLavelLabel.text = "Current speed: \(value)"
        }
    }
    
    func show(userName value: String) {
        userNameTextField.text = value
    }
}

// MARK: - Extensions

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chooseImage = info[.originalImage] as? UIImage {
            CherecterSettings.shared.setUserImage(with: chooseImage )
            userImageButton.setImage(CherecterSettings.shared.userImage, for: .normal)
            picker.dismiss(animated: true)
        }
    }
}
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userNameTextField.resignFirstResponder()
            controller.setUserName(with: textField.text ?? "")
        }
        return true
    }
}

