
//
//  FeedTrackCollectionViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 23.03.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import AVFoundation

class FeedTrackCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    //MARK: - Properties
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var track: TrackModelDeezer?
    var isFirstPlay = true
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playButton.layer.cornerRadius = 20
        
        var _ = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(self.updateSlider),
                                     userInfo: nil, repeats: true)
        
        playbackSlider.maximumTrackTintColor = UIColor.lightGray
        playbackSlider.minimumTrackTintColor = UIColor(red: 227/255.0,
                                                       green: 254/255.0,
                                                       blue: 34/255.0, alpha: 1)
        playbackSlider.setThumbImage(UIImage(), for: .normal)
    }
    
    //MARK: - Actions
    
    @IBAction func play(_ sender: UIButton) {
        
        if isFirstPlay {
            playTrack()
            isFirstPlay = false
        }
        if player?.rate == 0 {
            playbackSlider.isHidden = false
            player!.play()
            playButton.setImage(R.image.pause(), for: .normal)
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(notification:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: playerItem)
        } else {
            player!.pause()
            playButton.setImage(R.image.play(), for: .normal)
        }
    }
}

//MARK: - Public Methods

extension FeedTrackCollectionViewCell {
    
    func fill(with track: TrackModelDeezer) {
        
        albumLabel.text = track.album.title
        artistLabel.text = track.artist
        tittleLabel.text = track.title
        
        self.track = track
        
        guard let picURL = track.album.coverMd as URL! else {
            return
        }
        ImageLoader.loadImage(withURLString: picURL.absoluteString, handler: {result in
            switch result {
            case .success(image: let image):
                self.albumImageView.image = image
            case .failure:
                print("error")
            }
        })
    }
    
    func playTrack() {
        
        playerItem = AVPlayerItem(url: (track?.preview)!)
        player = AVPlayer(playerItem:playerItem)
        
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        playbackSlider.minimumValue = 0
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        playbackSlider.tintColor = UIColor.green
        playbackSlider.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:)),
                                 for: .valueChanged)
    }
    
    func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        player!.seek(to: targetTime)
        if player!.rate != 0
        {
            player?.play()
        }
    }
    
    func playerDidFinishPlaying(notification: Notification) {
        playbackSlider.isHidden = true
        playButton.setImage(R.image.play(), for: .normal)
        player?.seek(to: kCMTimeZero)
    }
    
    func removePlayer() {
        if player != nil {
            player = nil
            playButton.setImage(R.image.play(), for: .normal)
            playbackSlider.isHidden = true
            isFirstPlay = true
        }
    }
    
    func updateSlider() {
        guard let playerUnwrp = player as AVPlayer! else {
            return
        }
        playbackSlider.value = Float(playerUnwrp.currentTime().seconds)
    }
}
