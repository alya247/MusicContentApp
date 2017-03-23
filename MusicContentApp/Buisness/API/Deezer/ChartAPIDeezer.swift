//
//  ChartAPIDeezer.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class ChartAPIDeezer {
    
    enum Route {
        case tracks
        case albums
        case artists
        case playlists
        
        var method: HTTPMethod {
            switch self {
            case .tracks, .albums, .artists, .playlists: return .get
            }
        }
        
        var path: String {
            switch self {
            case .tracks:
                return API.apiURL.absoluteString + "/chart/0/tracks"
            case .albums:
                return API.apiURL.absoluteString + "/chart/0/albums"
            case .artists:
                return API.apiURL.absoluteString + "/chart/0/artists"
            case .playlists:
                return API.apiURL.absoluteString + "/chart/0/playlists"
            }
        }
    }
    
    static func getChartTracks(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        Alamofire.request(Route.tracks.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    static func getChartAlbums(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        Alamofire.request(Route.albums.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    static func getChartArtists(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
            Alamofire.request(Route.artists.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
    static func getChartPlaylists(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {

        Alamofire.request(Route.playlists.path).responseJSON { response in
            switch response.result {
            case .success(_):
                closure(response)
            case .failure:
                break
            }
        }
    }
}
