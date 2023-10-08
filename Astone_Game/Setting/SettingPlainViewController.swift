//
//  SettingPlainViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import Foundation
import UIKit


class SettingPlainViewController: UIViewController {
    private let firstPlainButton = UIButton()
    private let secondPlainButton = UIButton()
    private let theredPlainButton = UIButton()
    
    var completion: ((PlainImage) -> ())
    
    init (completion: @escaping (PlainImage) -> Void) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan.withAlphaComponent(0.1)
        
    }
    @objc private func plainImageTapped(_ target: UIButton) {
        switch target {
        case firstPlainButton:
            completion(PlainImage.plainOne)
        case secondPlainButton:
            completion(PlainImage.plainTwo)
        case theredPlainButton:
            completion(PlainImage.plainThree)
        default:
            return
        }
        self.dismiss(animated: true)
    }
    
    private func addElements() {
        firstPlainButton.translatesAutoresizingMaskIntoConstraints = false
        firstPlainButton.setImage(UIImage(named: PlainImage.plainOne.rawValue), for: .normal)
        view.addSubview(firstPlainButton)
        firstPlainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        firstPlainButton.heightAnchor.constraint(equalTo: firstPlainButton.widthAnchor).isActive = true
        firstPlainButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        firstPlainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        firstPlainButton.addTarget(self, action: #selector(plainImageTapped), for: .touchUpInside)
        
        secondPlainButton.translatesAutoresizingMaskIntoConstraints = false
        secondPlainButton.setImage(UIImage(named: PlainImage.plainTwo.rawValue), for: .normal)
        view.addSubview(secondPlainButton)
        secondPlainButton.widthAnchor.constraint(equalTo: firstPlainButton.widthAnchor, multiplier: 0.4).isActive = true
        secondPlainButton.heightAnchor.constraint(equalTo: firstPlainButton.heightAnchor).isActive = true
        secondPlainButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        secondPlainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        secondPlainButton.addTarget(self, action: #selector(plainImageTapped), for: .touchUpInside)
    }
}



//class SpaceShipSelectorViewController: UIViewController {
//
//    private let backgroundColorAlphaComponent: CGFloat = 0.1
//    private let spaceShipImageButtonsWidthMultiplier: CGFloat = 0.4
//    private let spaceShipImageButtonsIndentOfX: CGFloat = 10

//    override func viewDidLoad() {
//        prepare()
//    }
//
//    
//    private func prepare() {
//        

//        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
//        view.addGestureRecognizer(gesture)
//    }
//    
//}
