//
//  ViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/25/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet var Login: UIButton!
    
    @IBOutlet var SignUp: UIButton!
    
    @IBOutlet var FacebookButton: FBSDKLoginButton!
    
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    
    //Facebook Login Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print ("User logged in")
        
        if ((error) != nil) {
            //Process error
        } else if result.isCancelled {
            //Handle cancellations
        } else {
            //If you ask for multiple permissions at once, you
            //should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                //Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print ("User logged out")
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                //Process error
                print ("Error: \(error)")
            }else {
                print ("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print ("User Name is \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print ("User Email is \(userEmail)")
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //User is already logged in, do work such as go to the next ViewController
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

