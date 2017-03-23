//
//  MainViewController + CollectionViewLayout.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation

extension MainViewController {
    
    struct CollectionViewLayout {
        enum Row {
            case artists
            case tracks
            
            var cellIdentifier: String {
                switch self {
                case .artists: return R.reuseIdentifier.artistsFeed.identifier
                case .tracks: return R.reuseIdentifier.feedTracksCell.identifier
                }
            }
            
            func cellSize() -> CGSize {
                let width = UIScreen.main.bounds.width
                switch  self {
                case .artists: return CGSize(width: width, height: 320)
                case .tracks: return CGSize(width: width, height: 138)
                }
            }
        }
        static func rows() -> [Row] {
            return [.artists, .tracks]
        }
    }
}
