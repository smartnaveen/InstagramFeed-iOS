//
//  ImageCell.swift
//  FeedInstagram
//
//  Created by Naveen Kumar on 18/11/23.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with post: Video) {
        lblCaption.text = post.title
        setImage(url: post.thumbnailUrl, imgVw: imgVw)
    }
    
    func setImage(url:String,imgVw:UIImageView){
        imgVw.kf.indicatorType = .activity
        //DispatchQueue.main.async {
        imgVw.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "defaultImage"), options: nil) { (result) in
            switch result{
            case .success(let _):
                break
            case .failure(let error):
                print("dsds")
            }
        }
    }
}
