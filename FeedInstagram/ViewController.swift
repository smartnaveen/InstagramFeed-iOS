//
//  ViewController.swift
//  FeedInstagram
//
//  Created by Naveen Kumar on 18/11/23.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cblView: UICollectionView!{
        didSet{
            cblView.dataSource = self
            cblView.delegate = self
            cblView.registerNib(cell: VideoCell.self)
            cblView.registerNib(cell: ImageCell.self)
            cblView.isPagingEnabled = false
        }
    }
    
    var posts: [Video] = [Video]()
    var currentlyPlayingIndex: Int?
    var indx: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = GetData.getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let firstCell = cblView.cellForItem(at: IndexPath(item: 0, section: 0)) as? VideoCell {
            firstCell.playVideo()
            currentlyPlayingIndex = 0
        }
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = posts[indexPath.item]
        if post.videoUrl.hasSuffix(".mp4") {
            let cell = cblView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
            cell.configure(with: post)
            return cell
        } else {
            let cell = cblView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.configure(with: post)
            return cell
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        handleScrollEnd(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleScrollEnd(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            handleScrollEnd(scrollView)
        }
    }
        
    func handleScrollEnd(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let cellHeight = scrollView.bounds.height
        let currentIndex = Int(round(contentOffsetY / cellHeight))
        print("Current Index: \(currentIndex)")

        // Get the current cell
        if let currentCell = cblView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) {
            // Check if the current cell contains a video
            if let videoCell = currentCell as? VideoCell, isCellMostlyVisible(videoCell, threshold: 0.6, indx: IndexPath(row: currentIndex, section: 0)) {
                if let index = currentlyPlayingIndex {
                    let previousCell = cblView.cellForItem(at: IndexPath(item: index, section: 0)) as? VideoCell
                    previousCell?.pauseVideo()
                }
                currentlyPlayingIndex = currentIndex
                videoCell.playVideo()
                print("videoCell")
            } else {
                if let index = currentlyPlayingIndex {
                    let previousCell = cblView.cellForItem(at: IndexPath(item: index, section: 0)) as? VideoCell
                    previousCell?.pauseVideo()
                    currentlyPlayingIndex = nil
                }
                print("image cell")
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCell {
            videoCell.pauseVideo()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return(CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height))
    }
    
    func isCellMostlyVisible(_ cell: UICollectionViewCell, threshold: CGFloat = 0.7, indx: IndexPath) -> Bool {
        let cellRect = cblView.layoutAttributesForItem(at: indx)?.frame ?? CGRect.zero
        let convertedRect = cblView.convert(cellRect, to: cblView.superview)
        let visibleHeight = min(cellRect.height, cblView.bounds.height - max(0, cblView.contentOffset.y - cellRect.minY)) / cellRect.height
        print("Cell Rect: \(cellRect)")
        print("Converted Rect: \(convertedRect)")
        print("Visible Height: \(visibleHeight)")
        return visibleHeight >= threshold
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

