//
//  PostData.swift
//  Instagram
//
//  Created by nakaharak29 on 8/12/16.
//  Copyright © 2016 kenic. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {

    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    // (課題) コメント用の定数を追加
    var comments: [[String:String]] = []
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = valueDictionary["name"] as? String
        
        caption = valueDictionary["caption"] as? String
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDictionary["time"] as! NSTimeInterval)
        
        // (課題) コメント用の処理を追加
        if let comments = valueDictionary["comments"] as? [[String:String]] {
            self.comments = comments
        }
        
    }
    
}
