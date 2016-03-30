//
//  ViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/25/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    //User Login
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func loginTapped(sender: UIButton) {
        //Authentication Code
        let email:NSString = txtEmail.text!
        let password:NSString = txtPassword.text!
        
        if ( email.isEqualToString("") || password.isEqualToString("") ) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign In Failed"
            alertView.message = "Please enter your email and password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            do {
                let post:NSString = "email=\(email)&password=\(password)"
                
                NSLog("PostData %@", post);
                
                let url:NSURL = NSURL(string: "https://joynem.herokuapp.com/parse")!
                
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
                let postLength:NSString = String( postData.length )
                
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.HTTPBody = postData
                request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                var responseError: NSError?
                var response: NSURLResponse?
                var urlData: NSData?
                
                do {
                    urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                } catch let error as NSError {
                    responseError = error
                    urlData = nil
                }
                if ( urlData != nil) {
                    let res = response as! NSHTTPURLResponse!;
                    
                    NSLog("Response code: %ld", res.statusCode);
                    
                    if (res.statusCode >= 200 && res.statusCode < 300) {
                        
                        let responseData:NSString = NSString(data: urlData!, encoding: NSUTF8StringEncoding)!
                        
                        NSLog("Response ==> %ld", responseData);
                        
                        //var error: NSError?
                        
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if (success == 1) {
                            NSLog("Login SUCCESS");
                            
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(email, forKey: "EMAIL")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign In Failed"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        }
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign In Failed"
                        alertView.message = "Connection Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign In Failed"
                    alertView.message = "Connection Failed"
                    if let error = responseError {
                        alertView.message = (error.localizedDescription)
                    }
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } catch {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign In Failed"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }
    
    
    //Facebook Login
    @IBOutlet var FacebookButton: FBSDKLoginButton!
    
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
}
