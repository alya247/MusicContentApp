//
//  LoginViewController.swift
//  LastFMApp
//
//  Created by Alya Filon on 17.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 18
    }

    @IBAction func skipLogin(_ sender: UIButton) {
        //self.present(R.storyboard.search().instantiateInitialViewController()!, animated: true, completion: nil)
        /*self.present(R.storyboard.mainScreen().instantiateInitialViewController()!,
                     animated: true,
                     completion: nil)
        */self.present(R.storyboard.menu().instantiateInitialViewController()!,
                     animated: true,
                     completion: nil)
 
        //self.present(R.storyboard.artist().instantiateInitialViewController()!, animated: true, completion: nil)
    }
}
