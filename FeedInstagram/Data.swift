//
//  Data.swift
//  FeedInstagram
//
//  Created by Naveen Kumar on 18/11/23.
//

import Foundation
import UIKit

struct Video {
    var title: String
    var thumbnailUrl: String
    var videoUrl: String
}

class GetData: NSObject {
   static func getData() -> [Video] {
       var data: [Video] = [Video]()
       data = [
        Video(title: "Big Buck Bunny", thumbnailUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Big_Buck_Bunny_thumbnail_vlc.png/1200px-Big_Buck_Bunny_thumbnail_vlc.png", videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
        Video(title: "For Bigger Escape", thumbnailUrl: "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg", videoUrl: ""),
        Video(title: "The first Blender Open Movie from 2006", thumbnailUrl: "https://i.ytimg.com/vi_webp/gWw23EYM9VM/maxresdefault.webp", videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
        Video(title: "For Bigger Blazes", thumbnailUrl: "https://i.ytimg.com/vi/Dr9C2oswZfA/maxresdefault.jpg", videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
        Video(title: "For Bigger Escape", thumbnailUrl: "", videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
        Video(title: "The first Blender Open Movie from 2006", thumbnailUrl: "", videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),

       ]
       return data
    }
}
