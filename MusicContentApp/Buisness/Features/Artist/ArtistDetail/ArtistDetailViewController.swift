//
//  ArtistDetailViewController.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistDetailViewController: BaseViewController {

    @IBOutlet weak var artistDetailCollectionView: UICollectionView!
    
    var artistID: Int?

    var artist = ArtistModelDeezer()
    var albums = [AlbumModelDeezer]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        artistDetailCollectionView.register(R.nib.artistDetTitle)
        artistDetailCollectionView.register(R.nib.artistDetAlbums)
        artistDetailCollectionView.register(R.nib.artistDetRelated)
        artistDetailCollectionView.register(R.nib.artistDetTrack)
    }
}

extension ArtistDetailViewController: PushViewControllerProtocol {
    
    func pushViewController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ArtistDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return CollectionViewLayout.rows().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = CollectionViewLayout.rows()[indexPath.row]
        switch row {
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                          for: indexPath) as! ArtistDetTitleCollectionViewCell
            cell.fill(withArtist: artist)
            return cell
        case .albums:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                          for: indexPath) as! ArtistDetAlbumsCollectionViewCell
            cell.fill(withAlbums: albums)
            return cell
        case .related:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                          for: indexPath) as! ArtistDetRelatedCollectionViewCell
            cell.load(withArtistID: artistID!)
            cell.delegate = self
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.cellIdentifier,
                                                          for: indexPath) as! ArtistDetTrackCollectionViewCell
            cell.loadTracks(withID: artistID!)
            return cell
        }
    }
}

extension ArtistDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return CollectionViewLayout.rows()[indexPath.row].cellSize()
    }
}














