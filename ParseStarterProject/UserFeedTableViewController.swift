//
//  UserFeedTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dominic Gluhaich on 10/16/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class UserFeedTableViewController: UITableViewController, ComposeViewControllerDelegate {

    
    let reuseIdentifier = "Cell"
    private var posts: [PFObject]? {
        
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  navigationController?.navigationBar.barTintColor = UIColor(red: 81, green: 186, blue: 163, alpha: 100)

        // Query for feeds
        Downloader.sharedDownloader.queryForPosts()
        
        // Add observers
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryFeeds:", name: queryNotification, object: nil)
        /*
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
*/
           }
    // Notification SEL
    func queryFeeds(notification: NSNotification) {
        
        posts = notification.object as? [PFObject]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "postSegue" {
            
            let nav = segue.destinationViewController as! UINavigationController
            let composeVc = nav.topViewController as! ComposeViewController
            composeVc.delegate = self
        }
    }
    
    func dismissComposeViewController(viewController: ComposeViewController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func reloadTableViewAfterPosting() {
        
        dismissViewControllerAnimated(true, completion: nil)
        Downloader.sharedDownloader.queryForPosts()
        
    }

}
// MARK: - Table view data source

extension UserFeedTableViewController {


    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! cell
//Configure the cell
        if let posts = posts {
            let object = posts[indexPath.row]
            myCell.itemDescription?.text = object["post"] as? String
            myCell.itemDescription?.numberOfLines = 0
            myCell.itemTitle?.text = object["postTitle"] as? String
            
        }

        return myCell
    }
    

   
}
