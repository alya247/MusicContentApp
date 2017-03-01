//
//  BioCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class BioCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var likeButton: UIButton!
    
    var isSelectedButton = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(withArtist artist: ArtistModelDeezer) {
        //linkLabel.text = artist.link?.absoluteString
        
    }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        
        if isSelectedButton {
            //sender.setImage(R.image.likeUnselected(), for: .normal)
            isSelectedButton = false
        } else {
            sender.setImage(R.image.likeSelected(), for: .normal)
            isSelectedButton = true
        }
    }
}
