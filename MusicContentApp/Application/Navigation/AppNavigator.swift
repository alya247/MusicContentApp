//
//  AppNavigator.swift
//  LastFMApp
//
//  Created by Alya Filon on 17.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

class AppNavigator {
    
    func setupRootViewController(in window: UIWindow?) {
        
        do{ try  UserSession.shared.deactivate()
        } catch {}
        if UserSession.shared.isActive {
            
            window?.rootViewController =  R.storyboard.menu.menuVC()
            
        } else {
            //window?.rootViewController =  R.storyboard.menu.menuVC()
            window?.rootViewController = R.storyboard.login.loginVC()
        }

            
   
        window?.makeKeyAndVisible()
    }
}
