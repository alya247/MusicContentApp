//
//  API.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    enum OauthResult {
        
        case loggedIn(accessToken: String)
        case error
    }
    
    static var apiURL: URL {
        return URL(string: "http://api.deezer.com")!
    }
    
    static var oauthURL: String {
        return "https://connect.deezer.com/oauth"
    }
 
    static var appID: String {
        return "225404"
    }
    
    static var secretKey: String {
        return "1a492172b8194a6f900115c73bfece00"
    }
    
    static var redirectURI: String {
        return "http://www.example.com/"
    }
    
    enum Route {
        
        case oauthCode
        case accessToken(code: String)
        
        var method: HTTPMethod {
            switch self {
            case .oauthCode: return .get
            case .accessToken: return .get
            }
        }
        
        var path: String {
            switch self {
            case .oauthCode:
                return oauthURL + "/auth.php?app_id=" + appID + "&redirect_uri=" + redirectURI + "&perms=basic_access,email,offline_access,listening_history"
                
            case .accessToken(let code):
                return oauthURL + "/access_token.php?app_id=" + appID + "&secret=" + secretKey + "&code=" + code + "&response_type=token"
            }
        }
    }
    
    static func oauthCodeRequest() -> URL  {
        return URL(string: Route.oauthCode.path)!
    }
    
    static func accessTokenRequest(code: String, closure: @escaping (_ handler: Result<String>) -> Void)   {
        
        let request = Route.accessToken(code: code)
        
        Alamofire.request(request.path).responseString { response in
            closure(response.result)
        }
    }
}

