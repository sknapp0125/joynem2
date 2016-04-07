//
//  EventImageViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 4/5/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit
import Parse

class EventImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Display Alert
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    var activityIndicator = UIActivityIndicatorView() //Activity Indicator

    @IBOutlet var eventImageToPost: UIImageView!
    
    @IBAction func chooseImage(sender: AnyObject) {
        
        //Import Image
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        //When user has selected an image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        eventImageToPost.image = image //set the eventImageToPost to the image selected in Library
    }
    
    @IBOutlet var message: UITextField!
    
    @IBAction func postImage(sender: AnyObject) {
        
        //Activity Indicator
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        //
        
        let post = PFObject(className: "Post")
        
        post["message"] = message.text
        post["userId"] = PFUser.currentUser()!.objectId!
        
        //save image
        let imageData = UIImageJPEGRepresentation(eventImageToPost.image!, 1.0)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            
            //finish Activity Indicator
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            //
            
            if error == nil {
                
                self.displayAlert("Image Posted!", message: "Your image posted successfully")
                
                self.eventImageToPost.image = UIImage(named: "image2")
                
                self.message.text = ""
            } else {
                
                self.displayAlert("Image Did Not Post", message: "Please try again later")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
