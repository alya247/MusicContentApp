//
//  FeedTracksCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 23.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedTracksCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tracksCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var tracks = [TrackModelDeezer]()
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tracksCollectionView.register(R.nib.feedTrack)
        
        tracksCollectionView.dataSource = self
        tracksCollectionView.delegate = self
        
        ChartAPIDeezer.getChartTracks(closure: { [weak self] response in
            switch response.result {
            case .success(let jsonObj):
                self?.tracks.removeAll()
                let json = JSON(jsonObj)
                for (index,subJson):(String, JSON) in json {
                    if index == "data" {
                        for (_,sub):(String, JSON) in subJson {
                            let track = TrackModelDeezer()
                            track.parseJSON(JSONObj: sub)
                            self?.tracks.append(track)
                        }
                        
                        self?.tracksCollectionView.reloadData()
                    }
                }
            case .failure:
                print("error")
            }
        })
    }
}

extension FeedTracksCollectionViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.feedTrackCell, for: indexPath)! as FeedTrackCollectionViewCell
        
        cell.fill(with: tracks[indexPath.row])
        
        return cell
    }
}

extension FeedTracksCollectionViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 101)
    }
    
}







