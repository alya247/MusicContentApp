//
//  TrackAPIDeezer.swift
//  MusicContentApp
//
//  Created by Alya Filon on 23.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class TrackAPIDeezer {
    
    enum Route {
        case track(id: Int)
        
        var method: HTTPMethod {
            switch self {
            case .track: return .get
            }
        }
        
        var path: String {
            switch self {
            case .track(let id):
                return API.apiURL.absoluteString + "/track/" + String(id)
            }
        }
    }
    
    static func getArtist(withID id: Int, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.track(id: id)
        
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
