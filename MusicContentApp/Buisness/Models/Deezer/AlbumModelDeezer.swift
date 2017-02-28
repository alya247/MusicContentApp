//
//  AlbumModelDeezer.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import SwiftyJSON

class AlbumModelDeezer {
    
        var id: Int?
        var title: String?
        var link: URL?
        var share: URL?
        var coverSm: URL?
        var coverMd: URL?
        var coverBg: URL?
        var coverXl: URL?
        var genreId: Int?
        var fans: Int?
        var release: String?
    
    func parseJSON(JSONObj: JSON) {

        id = JSONObj["id"].int
        title = JSONObj["title"].string
        link = JSONObj["link"].url
        share = JSONObj["id"].url
        coverSm = JSONObj["cover_small"].url
        coverMd = JSONObj["cover_medium"].url
        coverBg = JSONObj["cover_big"].url
        coverXl = JSONObj["cover_xl"].url
        genreId = JSONObj["genre_id"].int
        fans = JSONObj["fans"].int
        release = JSONObj["release_date"].string
    }
}
