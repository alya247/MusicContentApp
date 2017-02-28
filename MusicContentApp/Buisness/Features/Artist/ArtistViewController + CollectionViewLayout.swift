//
//  ArtistViewController + CollectionViewLayout.swift
//  MusicContentApp
//
//  Created by Alya Filon on 26.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation

extension ArtistViewController {
    
    struct CollectionViewLayout {
        enum Row {
            case photo
            case desсription
            case albums
            
            var cellIdentifier: String {
                switch self {
                case .photo: return R.reuseIdentifier.artistPhoto.identifier
                case .desсription: return R.reuseIdentifier.shortBioCell.identifier
                case .albums: return R.reuseIdentifier.artistAlbumCell.identifier
                }
            }

            func cellSize() -> CGSize {
                let width = UIScreen.main.bounds.width
                switch  self {
                case .photo: return CGSize(width: width, height: width)
                case .desсription: return CGSize(width: width, height: 120.0)
                case .albums: return CGSize(width: width, height: 172.0)
                }
            }
        }
        static func rows() -> [Row] {
            return [.photo, .desсription, .albums]
        }
    }
}
