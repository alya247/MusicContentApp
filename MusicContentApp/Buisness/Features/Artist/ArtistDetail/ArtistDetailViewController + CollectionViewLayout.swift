//
//  ArtistDetailViewController + CollectionViewLayout.swift
//  MusicContentApp
//
//  Created by Alya Filon on 27.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation

extension ArtistDetailViewController {
    
    struct CollectionViewLayout {
        enum Row {
            case title
            case albums
            case related
            case tracks
            
            var cellIdentifier: String {
                switch self {
                case .title: return R.reuseIdentifier.artistDetTitleCell.identifier
                case .albums: return R.reuseIdentifier.artistDetAlbumsCell.identifier
                case .related: return R.reuseIdentifier.artistDetRelatedCell.identifier
                case .tracks: return R.reuseIdentifier.artistDetTrackCell.identifier
                }
            }
            
            func cellSize() -> CGSize {
                let width = UIScreen.main.bounds.width
                switch  self {
                case .title: return CGSize(width: width, height: 170.0)
                case .albums: return CGSize(width: width, height: 223.0)
                case .related: return CGSize(width: width, height: 207.0)
                case .tracks: return CGSize(width: width, height: 369.0)
                }
            }
        }
        static func rows() -> [Row] {
            return [.title, .albums, .related, .tracks]
        }
    }
}
