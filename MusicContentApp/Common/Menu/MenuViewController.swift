//
//  MenuViewController.swift
//  MusicContentApp
//
//  Created by Alya Filon on 19.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        profileImageView.layer.cornerRadius = 17
    }
    
}

