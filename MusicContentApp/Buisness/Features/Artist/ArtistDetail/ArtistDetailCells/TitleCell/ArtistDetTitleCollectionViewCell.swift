//
//  ArtistDetTitleCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class ArtistDetTitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ArtistDetTitleCollectionViewCell {

    // MARK: - Public Methods
    
    func fill(withArtist artist: ArtistModelDeezer) {
        
        nameLabel.text = artist.name
        
        guard let url = artist.pictureBg as URL! else {
            return
        }
        ImageLoader.loadImage(withURLString: url.absoluteString, handler: {result in
            switch result {
            case .success(image: let image):
                self.artistImageView.image = image
            case .failure:
                print("error")
            }
        })
    }
}
