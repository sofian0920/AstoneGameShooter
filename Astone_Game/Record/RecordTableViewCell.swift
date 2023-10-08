//
//  RecordTableViewCell.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    private let scoreLabel = UILabel()
    
    static let identifier = "RecordTableViewCell"
    
    func prepare(with scoreValue: String) {
        self.backgroundColor = .cyan
        scoreLabel.text = scoreValue
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .left
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scoreLabel)
        scoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        scoreLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scoreLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
}
