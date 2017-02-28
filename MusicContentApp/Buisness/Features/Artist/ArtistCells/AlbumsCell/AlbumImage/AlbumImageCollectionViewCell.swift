//
//  AlbumImageCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 19.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class AlbumImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setAlbumImage(withURL imageURl: URL) {
        guard let url = imageURl as URL! else {
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
