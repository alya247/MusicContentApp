//
//  ArtistsFeedCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistsFeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var artistsCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    let cells = [UIColor.blue, UIColor.red, UIColor.green]
    var artists = [ArtistModelDeezer]()
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        artistsCollectionView.dataSource = self
        artistsCollectionView.delegate = self
        
        artistsCollectionView.register(R.nib.artist)
        
        ChartAPIDeezer.getChartArtists(closure: { [weak self] response in
            switch response.result {
            case .success(let jsonObj):
                self?.artists.removeAll()
                let json = JSON(jsonObj)
                for (index,subJson):(String, JSON) in json {
                    if index == "data" {
                        for (_,sub):(String, JSON) in subJson {
                            let artist = ArtistModelDeezer()
                            artist.parseJSON(JSONObj: sub.object)
                            self?.artists.append(artist)
                        }
                        self?.artistsCollectionView.reloadData()
                    }
                }
            case .failure:
                print("error")
            }
        })

    }
}

// MARK: - PublicMethods

extension ArtistsFeedCollectionViewCell {
    
}

// MARK: - UICollectionViewDataSource

extension ArtistsFeedCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.artistCell,
                                                      for: indexPath)! as ArtistCollectionViewCell
        
        guard artists.count > 0 else {
            return cell
        }
        cell.fill(with: artists[indexPath.row])
        
        
        return cell
    }
}

extension ArtistsFeedCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 233, height: 278)
    }
}
