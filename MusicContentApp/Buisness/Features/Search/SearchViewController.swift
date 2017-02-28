//
//  SearchViewController.swift
//  MusicContentApp
//
//  Created by Alya Filon on 20.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: BaseViewController {
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    var artists = [ArtistModelDeezer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBarButtonItem.target = self.revealViewController()
        menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))

        searchBar.placeholder = "Search artist"
        searchBar.barStyle = .blackTranslucent
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        searchTableView.register(R.nib.searchCell)

    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchAPIDeezer.getArtist(withKeywords: searchText, closure: { [weak self] response in
            switch response.result {
            case .success(let jsonObj):
                self?.artists.removeAll()
                let json = JSON(jsonObj)
                for (index,subJson):(String, JSON) in json {
                    if index == "data" {
                        for (_,sub):(String, JSON) in subJson {
                            let artist = ArtistModelDeezer()
                            artist.parseJSON(JSONObj: sub.object)
                            self?.artists.append(artist)
                        }
                        self?.searchTableView.reloadData()
                    }
                }
            case .failure:
                print("error")
            }
        })
    }
    
    /*func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        artists.removeAll()
        searchTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        artists.removeAll()
        searchTableView.reloadData()
    }*/
}

extension SearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.fill(withArtist: artists[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let artistVC = R.storyboard.artist.artistVC()
        artistVC?.artistID = artists[indexPath.row].id!
        self.navigationController?.pushViewController(artistVC!, animated: true)
    }
}










