//
//  TrackDeezerModel.swift
//  MusicContentApp
//
//  Created by Alya Filon on 23.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import SwiftyJSON

class TrackModelDeezer {
    
    var id: Int?
    var title: String?
    var artist: String?
    var link: URL?
    var share: URL?
    var preview: URL?
    var contributors = Array<String>()
    
    func parseJSON(JSONObj: JSON) {
        
        id = JSONObj["id"].int
        title = JSONObj["title"].string
        //link = JSONObj["link"].url
        //share = JSONObj["id"].url
        preview = JSONObj["preview"].url
        artist = JSONObj["artist"]["name"].string
        
        let contributorsArray = JSONObj["contributors"].array
        for contributor in contributorsArray! {
            contributors.append(contributor["name"].string!)
        }
        
        print(contributors)
    }
}
