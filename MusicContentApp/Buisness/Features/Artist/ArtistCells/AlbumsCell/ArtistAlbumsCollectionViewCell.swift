//
//  ArtistAlbumsCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class ArtistAlbumsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    var albums = [AlbumModelDeezer]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        albumsCollectionView.delegate = self
        albumsCollectionView.dataSource = self
        albumsCollectionView.register(R.nib.albumImage)
    }
    
    func fill(withAlbums albums: [AlbumModelDeezer]) {
        self.albums = albums
    }
}

extension ArtistAlbumsCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumsCollectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumImageCell.identifier,
                                                            for: indexPath) as! AlbumImageCollectionViewCell

        guard let url = albums[indexPath.row].coverMd as URL! else {
            return cell
        }
        cell.setAlbumImage(withURL: url)
        return cell
    }
}

extension ArtistAlbumsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90.0, height: 90.0)
    }
}
