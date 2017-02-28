//
//  RelatedCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class RelatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var albumsNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(withRelatedArtist artist: ArtistModelDeezer) {
        
        nameLabel.text = artist.name
        fansLabel.text = String(describing: artist.fans)
        albumsNumberLabel.text = String(describing: artist.albumsNumber)
        
        guard let url = artist.pictureSm as URL! else {
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
