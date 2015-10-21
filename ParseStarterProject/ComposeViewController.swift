//
//  ComposeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Dominic Gluhaich on 10/16/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func dismissComposeViewController(viewController: ComposeViewController)
    func reloadTableViewAfterPosting()
}
class ComposeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageToPost: UIImageView!
    @IBAction func chooseImage(sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
    }
    
    //Delegate
    weak var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "posted:", name: postNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func posted(notification: NSNotification) {
        
        if let success = notification.object as? Bool {
            if success {
                
                //Dismiss
                delegate?.reloadTableViewAfterPosting()
            } else {
                if #available(iOS 8.0, *) {
                    let alert = UIAlertController(title: "Error", message: "Could not post", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) -> Void in
                        
                    }))
                    presentViewController(alert, animated: true, completion: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }

    }
    @IBAction func dismissViewController(sender: UIBarButtonItem) {
        
        delegate?.dismissComposeViewController(self)

    }
    @IBOutlet var itemTitle: UITextField!

    @IBAction func sendPost(sender: UIBarButtonItem) {
       
        let imageData = UIImagePNGRepresentation(imageToPost.image!)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        let post = PFObject(className: "UserFeed")
        
        post["imageFile"] = imageFile
        post.saveInBackground()
        

        if composeTextView.text != nil {
            Downloader.sharedDownloader.postFeed(composeTextView.text, postTitle: itemTitle.text!, image: imageToPost?.image)
        }
        /*
        if itemTitle.text != nil {
            Downloader.sharedDownloader.postFeed(itemTitle.itemTitle!)  
}
*/
       
    }
    
    @IBOutlet var composeTextView: UITextView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
