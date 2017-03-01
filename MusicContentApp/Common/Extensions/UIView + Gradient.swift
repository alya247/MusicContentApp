//
//  UIView + Gradient.swift
//  MusicContentApp
//
//  Created by Alya Filon on 23.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func blackGradient(withFrame frame: CGRect) {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.locations = [0.0, 0.8]
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.layer.addSublayer(layer)
    }
    
    func blackBackGradient(withFrame frame: CGRect) {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.locations = [0.8, 0.0]
        layer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        self.layer.addSublayer(layer)
    }
}
