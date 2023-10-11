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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .left
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            scoreLabel.topAnchor.constraint(equalTo: topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func prepare(with scoreValue: String) {
        self.backgroundColor = .clear
        scoreLabel.text = scoreValue
    }
}

