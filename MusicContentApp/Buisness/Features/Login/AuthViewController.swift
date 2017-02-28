//
//  AuthViewController.swift
//  MusicContentApp
//
//  Created by Alya Filon on 18.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire

class AuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://connect.deezer.com/oauth/auth.php?app_id=225404&redirect_uri=http://www.example.com/&perms=basic_access,email,offline_access,listening_history")
        let request = NSURLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        
        self.webView.loadRequest(request as URLRequest)
    }


}

extension AuthViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool  {
        
        
        
        let urlString: String = (request.url?.absoluteString)!
        print("URL STRING : \(urlString) ")
        var UrlParts: [String] = urlString.components(separatedBy: "http://www.example.com/?code=")
        
        if UrlParts.count > 1 {
            print(UrlParts[1])

            let url = URL(string: "https://connect.deezer.com/oauth/access_token.php?app_id=225404&secret=63d2a3d0416c6ae12f0d5915a2dc123e&code=" + UrlParts[1] + "&response_type=token")

            print(url!)
            
            Alamofire.request(url!).responseString { response in
                
                print(response.result)
                switch response.result {
                case .success(let result):
                    var UrlParts: [String] = result.components(separatedBy: "access_token=")
                    if UrlParts.count > 1 {
                        var UrlParts2: [String] = UrlParts[1].components(separatedBy: "&expires=0")
                        if UrlParts2.count > 1 {
                            let accessToken = UrlParts2[0]
                            print(accessToken)
                            do {
                                try UserSession.shared.activate(with: accessToken)
                                //self.present(R.storyboard.artist().instantiateInitialViewController()!, animated: true, completion: nil)
                                //self.present(R.storyboard.search().instantiateInitialViewController()!, animated: true, completion: nil)
                                self.present(R.storyboard.mainScreen().instantiateInitialViewController()!,
                                             animated: true,
                                             completion: nil)
                            }  catch _ {}
                        }
                    }
                case .failure:
                    print("error")
                }
            }
            return false
        }

        return true
    }

}
