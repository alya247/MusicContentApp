//
//  MainViewController.swift
//  MusicContentApp
//
//  Created by Alya Filon on 27.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if self.revealViewController() != nil {
            
            menuBarButtonItem.target = self.revealViewController()
            menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        feedCollectionView.register(R.nib.artistsFeed)
        feedCollectionView.register(R.nib.feedTracks)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return CollectionViewLayout.rows().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row =  CollectionViewLayout.rows()[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CollectionViewLayout.rows()[indexPath.row].cellSize()
    }
}



