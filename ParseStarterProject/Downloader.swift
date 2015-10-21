//
//  Downloader.swift
//  ParseStarterProject-Swift
//
//  Created by Dominic Gluhaich on 10/16/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit


let queryNotification = "queryUserFeedNotification"
let postNotification = "postNotification"

class Downloader: NSObject {
    
    //Singleton
    
    static let sharedDownloader = Downloader()
    // Queries and returns the posts based on location
    func queryForPosts() {
    
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geopoint, error) in
            if !(error != nil) {
                if let geoPoint = geopoint {
                    
                    let query = PFQuery(className: "UserFeed")
                    query.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 30)
                    query.limit = 15
                    query.orderByDescending("createdAt")
                    
                    query.findObjectsInBackgroundWithBlock{ (object, error) in
                        if let object = object {
                            
                            let obj = object as! [PFObject]
                            print(obj)
                            dispatch_async(dispatch_get_main_queue()) {
                                
                            NSNotificationCenter.defaultCenter().postNotificationName(queryNotification, object: obj)
                            }
                        }
                        
                    }
                }
                
            }
}
}
    func postFeed(text: String, postTitle: String, image:UIImage?) {
        
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geopoint, error) in
            if let geopoint = geopoint {
                
                let object = PFObject(className: "UserFeed")
                object.setValue(image, forKey: "imageFile")
                object.setValue(text, forKey: "post")
                object.setValue(geopoint, forKey: "location")
                object.setValue(postTitle, forKey: "postTitle")
                if let user = PFUser.currentUser() {
                    object.setValue(user, forKey: "fromUser")
                }
                
                object.saveInBackgroundWithBlock({ (success, error) -> Void in
                  
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(postNotification, object: success)
                    })
                                    })
            }
        }
    }

}
