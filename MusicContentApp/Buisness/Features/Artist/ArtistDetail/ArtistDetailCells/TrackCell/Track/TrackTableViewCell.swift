//
//  TrackTableViewCell.swift
//  MusicContentApp
//
//  Created by Alya Filon on 24.02.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import AVFoundation

protocol StopAnotherPlayerProtocol: NSObjectProtocol {
    func stopAnotherPlayer()
}

class TrackTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    
    // MARK: - Properties
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var track: TrackModelDeezer?
    var isFirstPlay = true
    
    weak var delegate: StopAnotherPlayerProtocol?
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playButton.layer.cornerRadius = 18
        
        var _ = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(self.updateSlider),
                                     userInfo: nil, repeats: true)
        
        playbackSlider.maximumTrackTintColor = UIColor.lightGray
        playbackSlider.minimumTrackTintColor = UIColor(red: 227/255.0,
                                                       green: 254/255.0,
                                                       blue: 34/255.0, alpha: 1)
        playbackSlider.setThumbImage(UIImage(), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Public Methods

extension TrackTableViewCell {
    
    func updateSlider() {
        guard let playerUnwrp = player as AVPlayer! else {
            return
        }
        playbackSlider.value = Float(playerUnwrp.currentTime().seconds)
    }
    
    func fill(withTrack track: TrackModelDeezer) {
        
        self.track = track
        titleLabel.text = track.title
        for contributor in track.contributors {
            if contributor == track.contributors.first! {
                artistLabel.text = contributor
            } else {
                artistLabel.text = artistLabel.text! + " ft." + contributor
            }
        }
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
    
    // MARK: - Actions
    
    @IBAction func play(_ sender: UIButton) {
        
        if isFirstPlay {
            if delegate?.responds(to: Selector(("stopAnotherPlayer:"))) != nil {
                delegate?.stopAnotherPlayer()
            }
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

