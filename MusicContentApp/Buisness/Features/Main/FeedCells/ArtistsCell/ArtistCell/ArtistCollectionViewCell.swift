//
//  ArtistCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 23.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

//MARK: - PublicMethods

extension ArtistCollectionViewCell {
    
    func fill(with artist: ArtistModelDeezer) {
        
        nameLabel.text = artist.name
        
        guard let picURL = artist.pictureMd as URL! else {
            return
        }
        ImageLoader.loadImage(withURLString: picURL.absoluteString, handler: {result in
            switch result {
            case .success(image: let image):
                self.albumImageView.image = image
            case .failure:
                print("error")
            }
        })
    }
}
