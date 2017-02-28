//
//  MainViewController.swift
//  MusicContentApp
//
//  Created by Alya Filon on 27.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if self.revealViewController() != nil {
            
            menuBarButtonItem.target = self.revealViewController()
            menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
}
