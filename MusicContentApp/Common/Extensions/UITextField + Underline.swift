//
//  UITextField + Underline.swift
//  LastFMApp
//
//  Created by Alya Filon on 17.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func underlined() {
        let border = CALayer()
        let width: CGFloat = 1.0
        border.borderColor = UIColor(red: 227.0/255, green: 252.0/255, blue: 64.0/255, alpha: 1).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
