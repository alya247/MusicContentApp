//
//  NavigationBar + Appearence.swift
//  MusicContentApp
//
//  Created by Alya Filon on 28.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    static func setup() {
        let appearance = UINavigationBar.appearance()
        appearance.setBackgroundImage(UIImage.gradientNavBar(withFrame: CGRect(x: 0, y: 0,
                                                                               width: UIScreen.main.bounds.width,
                                                                               height: 44.0)), for: .default)
    }
}
