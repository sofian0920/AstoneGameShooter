//
//  SettingPlainViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import Foundation
import UIKit




class SettingPlainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let firstPlainButton = UIButton()
    private let secondPlainButton = UIButton()
    private let thirdPlainButton = UIButton()
    
    var completion: ((PlainImage) -> ())
    
    // MARK: - Initialization
    
    init (completion: @escaping (PlainImage) -> Void) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.1)
        addElements()
        
    }
    
    
    // MARK: - Button Actions
    
    @objc private func plainImageTapped(_ target: UIButton) {
            switch target {
            case firstPlainButton:
                completion(PlainImage.plainOne)
            case secondPlainButton:
                completion(PlainImage.plainTwo)
            case thirdPlainButton:
                completion(PlainImage.plainThree)
            default:
                return
            }
            self.dismiss(animated: true)
        }
    
    
    // MARK: - UI Setup
    
    private func addElements() {

        let buttonWidthMultiplier: CGFloat = 0.4
        let buttonSpacing: CGFloat = 100.0

        firstPlainButton.translatesAutoresizingMaskIntoConstraints = false
               firstPlainButton.setImage(UIImage(named: PlainImage.plainOne.rawValue), for: .normal)
               view.addSubview(firstPlainButton)
               firstPlainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: buttonWidthMultiplier).isActive = true
               firstPlainButton.heightAnchor.constraint(equalTo: firstPlainButton.widthAnchor).isActive = true
               firstPlainButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -buttonSpacing).isActive = true
               firstPlainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
               firstPlainButton.addTarget(self, action: #selector(plainImageTapped), for: .touchUpInside)
               
               secondPlainButton.translatesAutoresizingMaskIntoConstraints = false
               secondPlainButton.setImage(UIImage(named: PlainImage.plainTwo.rawValue), for: .normal)
               view.addSubview(secondPlainButton)
               secondPlainButton.widthAnchor.constraint(equalTo: firstPlainButton.widthAnchor).isActive = true
               secondPlainButton.heightAnchor.constraint(equalTo: firstPlainButton.heightAnchor).isActive = true
               secondPlainButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: buttonSpacing).isActive = true
               secondPlainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
               secondPlainButton.addTarget(self, action: #selector(plainImageTapped), for: .touchUpInside)
               
               thirdPlainButton.translatesAutoresizingMaskIntoConstraints = false
               thirdPlainButton.setImage(UIImage(named: PlainImage.plainThree.rawValue), for: .normal)
               view.addSubview(thirdPlainButton)
               thirdPlainButton.widthAnchor.constraint(equalTo: firstPlainButton.widthAnchor).isActive = true
               thirdPlainButton.heightAnchor.constraint(equalTo: firstPlainButton.heightAnchor).isActive = true
               thirdPlainButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: buttonSpacing * 2).isActive = true
               thirdPlainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
               thirdPlainButton.addTarget(self, action: #selector(plainImageTapped), for: .touchUpInside)
           }
}
