//
//  ArtistViewController.swift
//  LastFMApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistViewController: BaseViewController {
    
    @IBOutlet weak var artistCollectionView: UICollectionView!
    @IBOutlet weak var openMenuBarButtonItem: UIBarButtonItem!
    
    var artistID: Int?
    
    var artist = ArtistModelDeezer()
    var albums = [AlbumModelDeezer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        artistCollectionView.register(R.nib.artistPhoto)
        artistCollectionView.register(R.nib.shortBio)
        artistCollectionView.register(R.nib.artistAlbums)
        
        ArtistAPIDeezer.getArtist(withID: artistID!, closure: { response in
            switch response.result {
            case .success(let json):
                self.artist.parseJSON(JSONObj: json)
                self.artistCollectionView.reloadItems(at: [IndexPath(row: 0, section: 0),
                                                           IndexPath(row: 1, section: 0)])
            case .failure:
                print("error")
            }
        })
        
        ArtistAPIDeezer.getAlbums(withID: artistID!, closure: { response in
            switch response.result {
            case .success(let jsonObj):
                
                let json = JSON(jsonObj)
                for (index,subJson):(String, JSON) in json {
                    if index == "data" {
                        for (_,sub):(String, JSON) in subJson {
                            let album = AlbumModelDeezer()
                            album.parseJSON(JSONObj: sub)
                            self.albums.append(album)
                        }
                        self.artistCollectionView.reloadItems(at: [IndexPath(row: 0, section: 0),
                                                                   IndexPath(row: 2, section: 0)])
                    }
                }
            case .failure:
                print("error")
            }
        })
    }
}

extension ArtistViewController: PushViewControllerProtocol {
    
    func pushViewController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ArtistViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return CollectionViewLayout.rows().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row =  CollectionViewLayout.rows()[indexPath.row]
        switch row {
        case .photo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                          for: indexPath) as! ArtistPhotoCollectionViewCell
            guard let a = artist as ArtistModelDeezer! else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                              for: indexPath)
                return cell
            }
            cell.delegate = self
            cell.fill(withArtist: a, albums: albums)
            return cell
        case .desсription:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier, for: indexPath) as! BioCollectionViewCell
            cell.fill(withArtist: artist)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                          for: indexPath) as! ArtistAlbumsCollectionViewCell
            cell.fill(withAlbums: albums)
            return cell
        }
    }
}

extension ArtistViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewLayout.rows()[indexPath.row].cellSize()
    }
}
