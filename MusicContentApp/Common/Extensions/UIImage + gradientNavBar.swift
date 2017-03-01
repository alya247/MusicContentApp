//
//  UIImage + gradientNavBar.swift
//  MusicContentApp
//
//  Created by Alya Filon on 01.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func gradientNavBar(withFrame frame: CGRect) -> UIImage {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0)
        gradientLayer.colors = [UIColor.black.cgColor,UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0.0, 0.8]
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
