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
    private var isPlainDead = true
    private let enemyView = EnemyView()
    private var isEnemyDead = true
    private let backgroundImage = UIImageView()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private var scoreLabel = UILabel()
    private var scoreCount = 0
    private let firePlainView: [UIImageView?] = []
    private var collisionTimer: Timer?
    private var buttonTimer: Timer?
    private let gameOverLabel = UILabel()
    private var isGameOver = false
    private let leftBorderView = BorderView()
    private let rightBorderView = BorderView()
    private let userName = CherecterSettings.shared.userName
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

        readyToPlay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGame()
    }
    
    func readyToPlay() {
        addRuleButten()
        addBackgroundView()
        addPlainView()
        addScoreLabel()
        addBorderLine()
    }
    
    
    @objc private func startTouchButton(_ sender: UIButton) {
        buttonTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            switch sender {
            case self?.leftButton:
                UIView.animate(withDuration: 0.6 , delay: 0, options: [.curveLinear]) {
                    self?.plainView.frame.origin.x -= 20
                }
            case self?.rightButton:
                UIView.animate(withDuration: 0.6 , delay: 0, options: [.curveLinear]) {
                    self?.plainView.frame.origin.x += 20
                }
            default:
                break
            }
        })
    }
    
    @objc private func stopTouchButton(_sender: UIButton){
        buttonTimer?.invalidate()
        buttonTimer = nil
    }
    
    
    private func addRuleButten() {
        leftButton.backgroundColor = .white
        leftButton.alpha = 0.2
        leftButton.layer.cornerRadius = 30
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(startTouchButton), for: .touchDown)
        leftButton.addTarget(self, action: #selector(stopTouchButton), for: .touchUpInside)
        leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonBottom).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        rightButton.backgroundColor = .white
        rightButton.alpha = 0.2
        rightButton.layer.cornerRadius = 30
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightButton)
        rightButton.addTarget(self, action: #selector(startTouchButton), for: .touchDown)
        rightButton.addTarget(self, action: #selector(stopTouchButton), for: .touchUpInside)
        rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
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
        scoreLabel.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -20).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scoreLabel.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor).isActive = true
        
    }
    
    private func addPlainView() {
        plainView.frame.size = CGSizeMake(view.frame.size.width * 0.18,  view.frame.size.height * 0.075)
               plainView.center.x = view.center.x
               plainView.frame.origin.y = view.frame.maxY - 240
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
        enemyView.frame.size = CGSizeMake(view.frame.width * 0.13, view.frame.height * 0.07)
        let enemyMinX = leftBorderView.frame.maxX + enemyView.frame.width / 2
        let enemyMaxX = rightBorderView.frame.minX - enemyView.frame.width / 2
        let enemeRandomPoint = CGFloat.random(in: enemyMinX...enemyMaxX)
        enemyView.frame.origin = CGPoint(x: enemeRandomPoint, y: -100)
        view.addSubview(enemyView)
    }
    
    private func startFallingEnemy() {
        UIView.animate(withDuration: CherecterSettings.shared.speedLevel.speed, delay: 0, options: [.curveLinear], animations: { [weak self] in
            guard let self = self else { return }
            self.enemyView.frame.origin.y = self.view.frame.maxY + self.enemyView.frame.height

        }) { [weak self] _ in
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
        fireCollisionCheck()
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
            UIView.animate(withDuration: 0.6, delay: 0.8, options: [.curveLinear], animations:  { [weak self] in
                self?.plainView.center.x = self?.view.center.x ?? 0
            }) { [weak self] _ in
                self?.plainView.isUserInteractionEnabled = true
                self?.isPlainDead = true
            }
            
        }
    }
    
    private func fireCollisionCheck() {
        for fire in firePlainView {
            guard let enemyFrame = enemyView.layer.presentation()?.frame else { return }
            guard let fireCheck = fire?.layer.presentation()?.frame.intersects(enemyFrame) else { return }
            if fireCheck {
                isEnemyDead = false
                fire?.removeFromSuperview()
                guard !isEnemyDead else { return }
                scoreCount += 1
                scoreLabel.text = "\(scoreCount)"
                enemyView.stopAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
                    self?.enemyView.removeFromSuperview()
                }
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
        let score = "\(userName)\(date) - \(scoreCount) your scores"
        CherecterSettings.shared.writeScore(with: score)
        
        view.layoutIfNeeded()
        gameOverLabel.text = "GAME OVER COUNT OF SCORES: \(scoreCount)"
        gameOverLabel.textColor = .red
        gameOverLabel.numberOfLines = 1
        gameOverLabel.font = .boldSystemFont(ofSize: backgroundImage.frame.width * 0.05)
        gameOverLabel.textAlignment = .center
        gameOverLabel.frame = CGRect(x: backgroundImage.frame.origin.x, y: backgroundImage.frame.origin.y, width: backgroundImage.frame.width, height: backgroundImage.frame.width * 0.15)
        view.addSubview(gameOverLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0, options: [.curveLinear], animations:  { [weak self] in
            guard let self = self else { return }
            let maxY = self.view.frame.maxY
            let gameOverHeight = self.gameOverLabel.frame.height
            self.gameOverLabel.frame.origin.y += maxY + gameOverHeight
        }) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
  
    private func invalidateAllTimers() {
        collisionTimer?.invalidate()
        collisionTimer = nil
    }
    
}
