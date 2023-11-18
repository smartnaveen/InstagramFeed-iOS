//
//  VideoCell.swift
//  FeedInstagram
//
//  Created by Naveen Kumar on 18/11/23.
//

import UIKit
import AVFoundation
import AVKit

class VideoCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var mediaView: UIView!
    var player: AVPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playVideo()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pauseVideo()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        player?.currentItem?.asset.loadValuesAsynchronously(forKeys: ["tracks"]) {
            DispatchQueue.main.async {
                let playerLayer = AVPlayerLayer(player: self.player)
                playerLayer.frame = self.mediaView.bounds
                playerLayer.videoGravity = .resizeAspectFill
                self.mediaView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                self.mediaView.layer.addSublayer(playerLayer)
            }
        }
    }
    
    func configure(with post: Video) {
        lblCaption.text = post.title
        configureVideoPlayer(with: URL(string: post.videoUrl)!)
    }
    
    private func configureVideoPlayer(with videoURL: URL) {
        let playerItem = AVPlayerItem(url: videoURL)
        player = AVPlayer(playerItem: playerItem)
        DispatchQueue.main.async {
            let playerLayer = AVPlayerLayer(player: self.player)
            playerLayer.frame = self.mediaView.bounds
            playerLayer.videoGravity = .resizeAspectFill
            self.mediaView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.mediaView.layer.addSublayer(playerLayer)
            self.mediaView.layer.masksToBounds = true
            self.mediaView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
        
    func playVideo() {
        player?.play()
        player?.volume = 1.0
    }
    
    func pauseVideo() {
        player?.pause()
        player?.volume = 0
    }
    
}
