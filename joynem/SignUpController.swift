//
//  SignUpController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/27/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    @IBOutlet var firstNametxt: UITextField!
    @IBOutlet var lastNametxt: UITextField!
    @IBOutlet var emailtxt: UITextField!
    
    @IBOutlet var passwordtxt: UITextField!
    @IBOutlet var confirmPasswordtxt: UITextField!
    
    @IBOutlet var BDayTextField: UITextField!
    @IBOutlet var BDayDatePicker: UIDatePicker!
    
    @IBOutlet var MaleBtn: DownStateButton?
    @IBOutlet var FemaleBtn: DownStateButton?
    
    
    @IBAction func createTapped(sender: UIButton) {
        let first_name:NSString = firstNametxt.text!
        let last_name:NSString = lastNametxt.text!
        let email:NSString = emailtxt.text!
        let password:NSString = passwordtxt.text!
        let confirm_password:NSString = confirmPasswordtxt.text!
        
        if ( email.isEqualToString("") || first_name.isEqualToString("") || last_name.isEqualToString("") || password.isEqualToString("") ){
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed"
            alertView.message = "Please enter your information"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if ( !password.isEqual(confirm_password) ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed"
            alertView.message = "Passwords Do Not Match"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            do {
                let post:NSString = "email=\(email)&password=\(password)&c_password=\(confirm_password)"
                
                NSLog("PostData: %&", post);
                
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
                
                if (urlData != nil) {
                    let res = response as! NSHTTPURLResponse!;
                    
                    NSLog("Response code: &ld", res.statusCode);
                    
                    if (res.statusCode >= 200 && res.statusCode < 300) {
                        
                        let responseData:NSString = NSString(data:urlData!, encoding: NSUTF8StringEncoding)!
                        
                        NSLog("Response ==> %@", responseData);
                        
                        //var error: NSError?
                        
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if (success == 1) {
                            
                            NSLog("Sign Up SUCCESS");
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil {
                                error_msg = jsonData["error_message"] as! NSString
                            } else {
                                error_msg = "Unknown Error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign Up Failed"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        }
                    } else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed"
                        alertView.message = "Connection Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign In Failed"
                    alertView.message = "Connection Failure"
                    if let error = responseError {
                        alertView.message = (error.localizedDescription)
                    }
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } catch {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign Up Failed"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
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
