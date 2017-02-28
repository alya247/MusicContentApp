//
//  ArtistDetTrackCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistDetTrackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tracksTableView: UITableView!
    
    var tracks = [TrackModelDeezer]()
    
    var artistID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tracksTableView.register(R.nib.track)
        tracksTableView.dataSource = self
    }
    
    func loadTracks(withID artistID: Int) {
        
        self.artistID = artistID
        
        ArtistAPIDeezer.getTop(withID: artistID, closure: {[weak self] response in
            switch response.result {
            case .success(let jsonObj):

                let json = JSON(jsonObj)
                for (index,subJson):(String, JSON) in json {
                    
                    if index == "data" {
                        
                        for (_, sub):(String, JSON) in subJson {
                            
                            let track = TrackModelDeezer()
                            track.parseJSON(JSONObj: sub)
                            self?.tracks.append(track)
                        }
                        self?.tracksTableView.reloadData()
                    }
                }
                
            case .failure:
                print("error")
            }
        })
    }
}

extension ArtistDetTrackCollectionViewCell: UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.trackCell.identifier, for: indexPath) as! TrackTableViewCell
        
        cell.fill(withTrack: tracks[indexPath.row])
        
        return cell
    }
}
