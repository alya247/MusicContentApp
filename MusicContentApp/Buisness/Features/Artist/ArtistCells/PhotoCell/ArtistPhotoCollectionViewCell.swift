//
//  ArtistPhotoCollectionViewCell.swift
//  LastFMApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

protocol PushViewControllerProtocol: NSObjectProtocol {
    func pushViewController(controller: UIViewController)
}

class ArtistPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistPictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toFavoriteButton: UIButton!
    @IBOutlet weak var blackGradientView: UIView!
    
    weak var delegate: PushViewControllerProtocol?
    
    var artistID: Int?
    var artist = ArtistModelDeezer()
    var albums = [AlbumModelDeezer]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        toFavoriteButton.layer.cornerRadius = 15
        blackGradientView.blackGradient(withFrame: blackGradientView.bounds)
    }
    
    func fill(withArtist artist: ArtistModelDeezer, albums: [AlbumModelDeezer]) {
        artistID = artist.id
        self.artist = artist
        self.albums = albums
        
        nameLabel.text = artist.name
        
        guard let url = artist.pictureBg as URL! else {
            return
        }
        ImageLoader.loadImage(withURLString: url.absoluteString, handler: {result in
            switch result {
            case .success(image: let image):
                self.artistPictureImageView.image = image
            case .failure:
                print("error")
            }
        })
    }
    
    @IBAction func showDetail(_ sender: UIButton) {
 
        let detailArtistVC = R.storyboard.artist.artistDetailVC() as ArtistDetailViewController!
        detailArtistVC?.artistID = artistID!
        detailArtistVC?.artist = artist
        detailArtistVC?.albums = albums
        if delegate?.responds(to: Selector(("pushViewController:"))) != nil {
            delegate?.pushViewController(controller: detailArtistVC!)
        }
    }
}
