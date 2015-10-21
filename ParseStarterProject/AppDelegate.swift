/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit

import Parse



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

   
    // Application Key
    private let appKey = "09eYb6ieToL4KrJVM36TJ8wJvQ25mtB9JCtPDGMD"
    // Client Key
    private let clientKey = "SsxfGMmcBJuHeomGoS94T7tcZ6zuqJ8Ht55AuXWo"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor(red: 81/255, green: 186/255, blue: 163/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 24)!]
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

       
        // Imp
        Parse.setApplicationId(appKey, clientKey: clientKey)
        
        // Log in Anonymously
        if !(PFUser.currentUser() != nil) {
            PFAnonymousUtils.logInWithBlock { (user, error) in
                print(user)
            }
        }
        
        return true
    }
    
    
}
