//
//  SearchTableViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 21.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var artistPictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var albumsLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(withArtist artist: ArtistModelDeezer) {
        nameLabel.text = artist.name
        albumsLabel.text = String(describing: artist.albumsNumber!) + " albums"
        fansLabel.text = String(describing: artist.fans!) + " fans"
        
        guard let picURL = artist.pictureMd as URL! else {
            return
        }
        ImageLoader.loadImage(withURLString: picURL.absoluteString, handler: {result in
            switch result {
            case .success(image: let image):
                self.artistPictureImageView.image = image
            case .failure:
                print("error")
            }
        })
    }
}
