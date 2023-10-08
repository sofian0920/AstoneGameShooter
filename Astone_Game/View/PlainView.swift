//
//  PlainView.swift
//  Astone_Game
//
//  Created by Софья Норина on 6.10.2023.
//

import UIKit

class PlainView: UIImageView {

    private let selfAnimationDuration = 0.9
    private let selfAnimationRepeatCount = 1

    convenience init() {
        self.init(image: Image.userPlain.wrappedValue)
        
    }
}
