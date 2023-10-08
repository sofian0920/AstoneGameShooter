//
//  BorderView.swift
//  Astone_Game
//
//  Created by Софья Норина on 7.10.2023.
//

import Foundation
import UIKit


final class BorderView: UIView{
    
     private let firstFalling = UIImageView()
     private let secondFalling = UIImageView()
     private var firstFrame = CGRect()
     private var secondFrame = CGRect()
     
     
    func startGame() {
        addBorgerView()
        movingBorder()
    }
    
    
     private func addBorgerView() {
         firstFalling.image = Image.border.wrappedValue
         self.addSubview(firstFalling)
         firstFalling.frame = self.bounds
         firstFrame = firstFalling.frame
         
         
         secondFalling.image = Image.border.wrappedValue
         self.addSubview(secondFalling)
         secondFalling.frame = self.bounds
         secondFalling.frame.origin.y = -self.bounds.height
         secondFrame = secondFalling.frame
     }

    
    private func movingBorder() {
        UIView.animate(withDuration: 1.6, delay: 0, options: [.curveLinear]) { [weak self] in
            self?.firstFalling.frame.origin.y = self?.bounds.height ?? 0
            self?.secondFalling.frame.origin.y = self?.bounds.height ?? 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.firstFalling.frame = self.firstFrame
            self.secondFalling.frame = self.secondFrame
            movingBorder()
        }
    }
}



//private let objectsAnimateDuration = 0.3
//
//func start() {
//    addObjectOnBorderView()
//    startObjectsMoving()
//}

//
//private func startObjectsMoving() {
//    UIView.animate(withDuration: objectsAnimateDuration, delay: 0, options: [.curveLinear]) { [weak self] in
//        self?.firstObject.frame.origin.y += self?.bounds.height ?? 0
//        self?.secondObject.frame.origin.y += self?.bounds.height ?? 0
//    } completion: { [weak self] _ in
//        guard let self = self else { return }
//        self.firstObject.frame = self.firstObjectStartedFrame
//        self.secondObject.frame = self.secondObjectStartedFrame
//        startObjectsMoving()
//    }
//}
//}
