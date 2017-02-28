//
//  ArtistAPILastFM.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class ArtistAPILastFM {
    
    enum Route {
        
        case artist
        case getTags
        
        var method: HTTPMethod {
            switch self {
            case .artist, .getTags: return .get
            }
        }
        
        var path: String {
            switch self {
            case .artist(let id):
                return "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=Cher&api_key=ac63a870ac4fed6536656336618d1396&format=json"
            case .getTags():
                return "http://ws.audioscrobbler.com/2.0/?method=artist.getTags&artist=Cher&user=RJ&api_key=ac63a870ac4fed6536656336618d1396&format=json"
            }
        }
    }
    
    static func getArtist(withID id: String, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.artist
        
        Alamofire.request(request.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    static func getTags(withID id: String, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.getTags
        
        Alamofire.request(request.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }

    
}
