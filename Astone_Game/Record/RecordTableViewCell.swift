//
//  RecordTableViewCell.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let scoreLabel = UILabel()
    
    // MARK: - Constants
    
    static let identifier = "RecordTableViewCell"
    private let leadingMargin: CGFloat = 25
    private let trailingMargin: CGFloat = -25
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Common Initialization
    
    private func commonInit() {
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .left
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingMargin),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingMargin),
            scoreLabel.topAnchor.constraint(equalTo: topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    func prepare(with scoreValue: String) {
        self.backgroundColor = .clear
