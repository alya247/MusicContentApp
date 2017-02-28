//
//  AlbumDetCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class AlbumDetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setAlbumInfo(withAlbum album: AlbumModelDeezer) {
        
        nameLabel.text = album.title
        
        print(album.coverMd)
        guard let url = album.coverMd as URL! else {
            return
        }
        ImageLoader.loadImage(withURLString: url.absoluteString, handler: {result in
            switch result {
            case .success(image: let image):
                self.albumImageView.image = image
            case .failure:
                print("error")
            }
        })
    }
    
}
