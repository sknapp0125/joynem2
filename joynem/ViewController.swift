//
//  ViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/25/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var loginButton: UIButton!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var errorMessage = "Please try again later"
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func login(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in Form", message: "Please enter your username and password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            
            
            PFUser.logInWithUsernameInBackground(self.username.text!, password: self.password.text!, block: { (user, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if user != nil {
                    //Logged in
                    
                    print((user!.email)!)
                    
                    self.performSegueWithIdentifier("login", sender: self)
                    
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        self.errorMessage = errorString
                    }
                    
                    self.displayAlert("Failed Sign Up", message: self.errorMessage)
                }
            })
        }
    }
    
    //Facebook Login
    //@IBOutlet var FacebookButton: FBSDKLoginButton!
    
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
        
        //Attach text fields to UITextFieldDelegate for hiding the keyboard
        self.username.delegate = self
        self.password.delegate = self
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //User is already logged in, do work such as go to the next ViewController
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
        let testObject = PFObject (className: "Test Object")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock {(success, error) -> Void in
            print ("Object has been saved")
        }
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
    
    //HIDE KEYBOARD
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
