//
//  BorderView.swift
//  Astone_Game
//
//  Created by Софья Норина on 7.10.2023.
//

import Foundation
import UIKit


final class BorderView: UIView{
    
     private let leftObject = UIImageView()
     private let rightObject = UIImageView()
     private var leftObgectFrame = CGRect()
     private var rightObgectFrame = CGRect()
     
     
    func startGame() {
        addBorgerView()
        movingBorder()
    }
    
    
     private func addBorgerView() {
         leftObject.image = Image.border.wrappedValue
         self.addSubview(leftObject)
         leftObject.frame = self.bounds
         leftObgectFrame = leftObject.frame
         
         
         rightObject.image = Image.border.wrappedValue
         self.addSubview(rightObject)
         rightObject.frame = self.bounds
         rightObject.frame.origin.y = -self.bounds.height
         rightObgectFrame = rightObject.frame
     }

    
    private func movingBorder() {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveLinear]) { [weak self] in
            self?.leftObject.frame.origin.y = self?.bounds.height ?? 0
            self?.rightObject.frame.origin.y = self?.bounds.height ?? 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.leftObject.frame = self.leftObgectFrame
            self.rightObject.frame = self.rightObgectFrame
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
