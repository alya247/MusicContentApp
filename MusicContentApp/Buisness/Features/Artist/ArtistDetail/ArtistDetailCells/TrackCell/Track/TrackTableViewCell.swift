//
//  TrackTableViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 24.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import AVFoundation

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var player: AVPlayer?
    
    var track: TrackModelDeezer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playButton.layer.cornerRadius = 18
    }
    
    func fill(withTrack track: TrackModelDeezer) {
        
        self.track = track
        
        titleLabel.text = track.title
        artistLabel.text = track.link?.absoluteString
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        
        //let path = Bundle.main.path(forResource: track?.preview?.absoluteString, ofType:nil)!
        //let url = URL(fileURLWithPath: path)
        
        /*weak var weakSelf = self
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: (track?.preview)!, completionHandler: { (URL, response, error) -> Void in
            
            do {
                self.player = try AVAudioPlayer(contentsOf: (self.track?.preview)!)
                //self.bombSoundEffect = sound
                
                self.player?.prepareToPlay()
                self.player?.volume = 1.0
                self.player?.play()
            } catch(let error) {
                
                print(error.localizedDescription)
            }
            
        })
        
        downloadTask.resume()
        */
        
        print("playing \((track?.preview)!)")
        
        self.player = nil
        
        do {
            
            let playerItem = AVPlayerItem(url: (track?.preview)!)
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
