//
//  ArtistAPIDeezer.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class ArtistAPIDeezer {
    
    enum Route {
        
        case artist(id: Int)
        case albums(id: Int)
        case related(id: Int)
        case top(id: Int)
        /*
        case albums
        case comments
        case fans
        case related
*/
        var method: HTTPMethod {
            switch self {
            case .artist, .albums, .related, .top: return .get
            }
        }
        
        var path: String {
            switch self {
            case .artist(let id):
                return API.apiURL.absoluteString + "/artist/" + String(id)
            case .albums(let id):
                return API.apiURL.absoluteString + "/artist/" + String(id) + "/albums"
            case .related(let id):
                return API.apiURL.absoluteString + "/artist/" + String(id) + "/related"
            case .top(let id):
                return API.apiURL.absoluteString + "/artist/" + String(id) + "/top"
            }
        }
    }
    
    static func getArtist(withID id: Int, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.artist(id: id)
        
        Alamofire.request(request.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    static func getAlbums(withID id: Int, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.albums(id: id)
        
        Alamofire.request(request.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    
    static func getRelated(withID id: Int, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.related(id: id)
        
        Alamofire.request(request.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    
    static func getTop(withID id: Int, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.top(id: id)
        
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
