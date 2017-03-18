//
//  ArtistDetAlbumsCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class ArtistDetAlbumsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var albums = [AlbumModelDeezer]()
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        albumsCollectionView.delegate = self
        albumsCollectionView.dataSource = self
        albumsCollectionView.register(R.nib.albumDetail)
    }
    
    // MARK: - Public Methods
    
    func fill(withAlbums albums: [AlbumModelDeezer]) {
        self.albums = albums
        albumsCollectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func showAllAlbums(_ sender: UIButton) {
    }
}

// MARK: - UICollectionViewDataSource

extension ArtistDetAlbumsCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumsCollectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumDetailCell.identifier, for: indexPath) as! AlbumDetCollectionViewCell
        
        cell.setAlbumInfo(withAlbum: albums[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ArtistDetAlbumsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150.0, height: 200.0)
    }
}

