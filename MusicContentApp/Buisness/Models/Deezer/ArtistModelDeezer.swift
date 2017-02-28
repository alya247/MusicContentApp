//
//  ArtistModelDeezer.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArtistModelDeezer {
    
    static let instance = ArtistModelDeezer()
    
    var id: Int?
    var name: String?
    var link: URL?
    var share: URL?
    var pictureSm: URL?
    var pictureMd: URL?
    var pictureBg: URL?
    var pictureXl: URL?
    var albumsNumber: Int?
    var fans: Int?
    
    func parseJSON(JSONObj: Any) {
        
        let json = JSON(JSONObj)
        
        id = json["id"].int
        name = json["name"].string
        link = json["link"].url
        share = json["share"].url
        pictureSm = json["picture_small"].url
        pictureMd = json["picture_medium"].url
        pictureBg = json["picture_big"].url
        pictureXl = json["picture_xl"].url
        albumsNumber = json["nb_album"].int
        fans = json["nb_fan"].int
    }
}
