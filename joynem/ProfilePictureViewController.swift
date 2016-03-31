//
//  ProfilePictureViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/31/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class ProfilePictureViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    //    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
        
        
        
        profileImage.image = image
        print(profileImage)
        
    }
    
    
    
    @IBAction func profileImageBtn(sender: AnyObject) {
        let profileImage = UIImagePickerController()
        profileImage.delegate = self
        profileImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        
        /////////////////////////////////////////////////////////////////////////
        // will cause crash if not hooked up to phone
        
        //profileImage.sourceType = UIImagePickerControllerSourceType.Camera
        
        /////////////////////////////////////////////////////////////////////////
        
        
        profileImage.allowsEditing = false
        
        self.presentViewController(profileImage, animated: true, completion:  nil)
        
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


