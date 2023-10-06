//
//  ViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 6.09.2023.
//

import UIKit

class StartViewController: UIViewController {
    private let backgroundImageView = UIImageView()
    private let startButton = UIButton()
    private let settingButton = UIButton()
    private let scoreButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundView()
        setUpStartView()
        
    }
    
    private func setUpStartView() {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30),
            .foregroundColor: UIColor.black
        ]
        
        let startButtonAttributes = NSAttributedString(string: "START", attributes: attributes)
        startButton.setAttributedTitle(startButtonAttributes, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        startButton.addTarget(self, action: #selector(buttonTub), for: .touchUpInside)
        
        let settingButtonAttributes = NSAttributedString(string: "SETTINGS", attributes: attributes)
        settingButton.setAttributedTitle(settingButtonAttributes, for: .normal)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingButton)
        settingButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor).isActive = true
        settingButton.topAnchor.constraint(equalTo: startButton.bottomAnchor).isActive = true
        settingButton.widthAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        settingButton.heightAnchor.constraint(equalTo: startButton.heightAnchor).isActive = true
        settingButton.addTarget(self, action: #selector(buttonTub), for: .touchUpInside)
        
        let scoreButtonAttributes = NSAttributedString(string: "SCORE", attributes: attributes)
        scoreButton.setAttributedTitle(scoreButtonAttributes, for: .normal)
        scoreButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreButton)
        scoreButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor).isActive = true
        scoreButton.topAnchor.constraint(equalTo: settingButton.bottomAnchor).isActive = true
        scoreButton.widthAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        scoreButton.heightAnchor.constraint(equalTo: startButton.heightAnchor).isActive = true
        
    }
    private func addBackgroundView() {
        backgroundImageView.image = Image.background.wrappedValue
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func buttonTub(_ target: UIButton){
        var viewController: UIViewController
        switch target {
        case startButton:
            viewController = GameViewController()
        case settingButton:
            viewController = SettingsViewController()
            
        default:
            return
        }
    }
}

