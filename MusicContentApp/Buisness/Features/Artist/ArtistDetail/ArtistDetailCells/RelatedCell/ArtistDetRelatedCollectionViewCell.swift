//
//  ArtistDetRelatedCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistDetRelatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    var relatedArtists = [ArtistModelDeezer]()
    
    var artistID: Int?
    
    weak var delegate: PushViewControllerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        relatedCollectionView.register(R.nib.related)
        relatedCollectionView.dataSource = self
        relatedCollectionView.delegate = self
        
        

    }
    
    func load(withArtistID id: Int) {
        artistID = id
        
        ArtistAPIDeezer.getRelated(withID: artistID!, closure: { [weak self] response in
            
            switch response.result {
            case .success(let jsonObj):
                
                self?.relatedArtists.removeAll()
                
                let json = JSON(jsonObj)
                for (index,subJson):(String, JSON) in json {

                    if index == "data" {
                        
                        for (_,sub):(String, JSON) in subJson {
                            let artist = ArtistModelDeezer()
                            
                            artist.parseJSON(JSONObj: sub.object)
                            self?.relatedArtists.append(artist)
                        }
                        self?.relatedCollectionView.reloadData()
                    }
                }
            case .failure:
                print("error")
            }
        })
    }
}

extension ArtistDetRelatedCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedArtists.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.relatedCell.identifier,
                                                      for: indexPath) as! RelatedCollectionViewCell
        cell.fill(withRelatedArtist: relatedArtists[indexPath.row])
        
        return cell
    }
}

extension ArtistDetRelatedCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistVC = R.storyboard.artist.artistVC()! as ArtistViewController
        artistVC.artistID = relatedArtists[indexPath.row].id!
        if delegate?.responds(to: Selector(("pushViewController:"))) != nil {
            delegate?.pushViewController(controller: artistVC)
        }
    }
}

extension ArtistDetRelatedCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 65.0)
    }
}
