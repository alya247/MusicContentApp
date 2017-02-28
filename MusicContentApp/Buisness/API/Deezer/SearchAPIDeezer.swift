//
//  SearchAPIDeezer.swift
//  MusicContentApp
//
//  Created by Alya Filon on 20.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class SearchAPIDeezer {
    
    enum Route {
        
        case artist(keywords: String)
        
        var method: HTTPMethod {
            switch self {
            case .artist: return .get
            }
        }
        
        var path: String {
            switch self {
            case .artist(let keywords):
                return API.apiURL.absoluteString + "/search/artist?q=" + keywords

            }
        }
    }
    
    static func getArtist(withKeywords keywords: String, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = Route.artist(keywords: keywords)
        
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
