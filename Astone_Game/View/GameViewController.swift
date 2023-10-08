//
//  GameViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 22.09.2023.
//

import Foundation
import UIKit


class GameViewController: UIViewController {
    private let plainView = PlainView()
    private var isPlainDead = false
    private let enemyView = EnemyView()
    private var isEnemyDead = false
    private let backgroundImage = UIImageView()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private var scoreLabel = UILabel()
    private var scoreCount = 0
    private var collisionTimer: Timer?
    private let gameOverLabel = UILabel()
    private var isGameOver = false
    private let leftBorderView = BorderView()
    private let rightBorderView = BorderView()
    private var userLife = 1 {
        willSet {
            if newValue <= 0 {
                gameOver()
            }
        }
    }
    
    
    
    private let buttonSide: CGFloat = 20
    private let buttonBottom: CGFloat = 40
    private let buttonSize: CGFloat = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        addRuleButten()
        addBackgroundView()
        addPlainView()
        addScoreLabel()
        addBorderLine()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGame()
    }
    
    @objc private func startTouchButton(_ sender: UIButton) {
        switch sender {
        case self.leftButton:
            UIView.animate(withDuration: 0.6 , delay: 0, options: [.curveLinear]) {
                self.plainView.frame.origin.x -= 20 
            }
        case self.rightButton:
            UIView.animate(withDuration: 0.6 , delay: 0, options: [.curveLinear]) {
                self.plainView.frame.origin.x += 20 
            }
        default:
            break
        }
    }
    
    @objc private func stopTouchButton(_sender: UIButton){
        
    }
    
    
    private func addRuleButten() {
        leftButton.backgroundColor = .cyan
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(startTouchButton), for: .touchDown)
        leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonSide).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonBottom).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        rightButton.backgroundColor = .cyan
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightButton)
        rightButton.addTarget(self, action: #selector(startTouchButton), for: .touchDown)
        rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonSide).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonBottom).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
    }
    
    private func addBorderLine() {
        leftBorderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftBorderView)
        leftBorderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftBorderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leftBorderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftBorderView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18).isActive = true
        
        
        rightBorderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightBorderView)
        rightBorderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightBorderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rightBorderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rightBorderView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18).isActive = true
        
        
        view.layoutIfNeeded()
        leftBorderView.startGame()
        rightBorderView.startGame()
        
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
    
    private func addScoreLabel() {
        scoreLabel.text = "\(scoreCount)"
        scoreLabel.textColor = .red
        scoreLabel.font = .boldSystemFont(ofSize: backgroundImage.frame.width * 0.08)
        scoreLabel.textAlignment = .right
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.addSubview(scoreLabel)
        scoreLabel.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scoreLabel.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor).isActive = true
        
    }
    
    private func addPlainView() {
        
        plainView.frame.size = CGSizeMake(view.frame.size.width * 0.18,  view.frame.size.height * 0.075)
        plainView.center.x = view.center.x
        plainView.frame.origin.y = view.frame.maxY - 120
        view.addSubview(plainView)
        
    }
    
    
    private func startGame(){
        addEnemy()
        startFallingEnemy()
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(checkCollisionTimer), userInfo: nil, repeats: true)
    }

    @objc private func checkCollisionTimer() {
        guard  userLife > 0 else { return }
        guard isPlainDead else { return }
        guard isEnemyDead else { return }
        plainCollisionCheck()
    }
    
    private func addEnemy() {
        isEnemyDead = true
        enemyView.frame.size = CGSizeMake(view.frame.width * 0.13, view.frame.height * 0.13)
        let emenyMinX = Int(backgroundImage.frame.origin.x)
        let enemyMaxX = Int(leftBorderView.frame.width + backgroundImage.frame.width - enemyView.frame.width)
        let enemeRandomPoint = Int.random(in: emenyMinX...enemyMaxX)
        enemyView.frame.origin = CGPoint(x: enemeRandomPoint, y: -100)
        view.addSubview(enemyView)
    }
    
    private func startFallingEnemy() {
        UIView.animate(withDuration: CherecterSettings.settingElement.speedLevel.speed, delay: 0, options: [.curveLinear]) { [weak self] in
            self?.enemyView.frame.origin.y = self?.view.frame.maxY ?? 0 + (self?.enemyView.frame.height ?? 0)
        } completion: { [weak self] _ in
            guard let isEnemyDead = self?.isEnemyDead, let isGameOver = self?.isGameOver else { return }
            if isEnemyDead && !isGameOver {
                self?.scoreCount += 1
                guard let scoreCount = self?.scoreCount else { return }
                self?.scoreLabel.text = "\(scoreCount)"
            }
            self?.enemyView.removeFromSuperview()
            self?.addEnemy()
            self?.startFallingEnemy()
        }
    }
    @objc private func collisionCheck() {
        guard userLife > 0 else { return }
        guard isPlainDead else { return }
        guard isEnemyDead else { return }
        plainCollisionCheck()
    }

    
    private func plainCollisionCheck() {

        guard let rightBorderCheck = plainView.layer.presentation()?.frame.intersects(rightBorderView.frame) else { return }
        guard let leftBorderCheck = plainView.layer.presentation()?.frame.intersects(leftBorderView.frame) else { return }
        guard let enemyCheck = enemyView.layer.presentation()?.frame.intersects(plainView.frame) else { return }
        
        if rightBorderCheck || leftBorderCheck || enemyCheck {
            userLife -= 1
            isPlainDead = false
            plainView.startAnimating()
            plainView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.6, delay: 0.8, options: [.curveLinear]) { [weak self] in
                self?.plainView.center.x = self?.view.center.x ?? 0
            } completion: { [weak self] _ in
                self?.plainView.isUserInteractionEnabled = true
                self?.isPlainDead = true
            }
            
        }
    }
    
    private func gameOver() {
        isGameOver = true
        
        let myTime = Date()
        let format = DateFormatter()
        format.timeStyle = .short
        format.dateStyle = .medium
        let date = format.string(from: myTime)
        let score = "\(date) - \(scoreCount) your scores"
        CherecterSettings.settingElement.writeScore(score)
        
        view.layoutIfNeeded()
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.textColor = .red
        gameOverLabel.font = .boldSystemFont(ofSize: backgroundImage.frame.width * 0.15)
        gameOverLabel.textAlignment = .center
        gameOverLabel.frame = CGRect(x: backgroundImage.frame.origin.x, y: backgroundImage.frame.origin.y, width: backgroundImage.frame.width, height: backgroundImage.frame.width * 0.15)
        view.addSubview(gameOverLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0, options: [.curveLinear]) { [weak self] in
            guard let maxY = self?.view.frame.maxY, let gameOverHeight = self?.gameOverLabel.frame.height else { return }
            self?.gameOverLabel.frame.origin.y += maxY + gameOverHeight
        } completion: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
  
    private func invalidateAllTimers() {
        collisionTimer?.invalidate()
        collisionTimer = nil
    }
    
}

