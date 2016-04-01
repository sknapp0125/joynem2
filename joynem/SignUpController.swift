//
//  SignUpController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/27/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit
import Parse

class SignUpController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    @IBOutlet var BDayPicker: UIDatePicker!
    
    @IBOutlet var BDayTextField: UITextField!
    
    @IBOutlet var maleButton: DownStateButton?
    
    @IBOutlet var femaleButton: DownStateButton?
    
    let dateFormat: NSDateFormatter = NSDateFormatter()
    var clickCounter = 0
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func create(sender: AnyObject) {
        
        if firstName.text == "" || lastName.text == "" || username.text == "" || email.text == "" || password.text == "" {
            
            displayAlert("Error in Form", message: "Please enter your information")
            
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
            user.email = email.text
            user["firstName"] = firstName.text
            user["lastName"] = lastName.text
            
            
            var errorMessage = "Please try again later"
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    
                    //Sign Up Successful
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                    }
                    
                    self.displayAlert("Failed Sign Up", message: errorMessage)
                }
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Disables Bday textfield
        BDayTextField.delegate = self
        BDayTextField.inputView = BDayPicker
        
        //Hides date picker
        BDayPicker.hidden = true
        BDayPicker.datePickerMode = UIDatePickerMode.Date
        BDayPicker.addTarget(self, action: #selector(SignUpController.updateBdayTextField(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        //Setup the date format
        dateFormat.dateStyle = NSDateFormatterStyle.ShortStyle
        
        //Setup Radio Buttons
        maleButton?.downStateImage = "radioBtnYes.png"
        maleButton?.myAltBtn = [femaleButton!]
        
        femaleButton?.downStateImage = "radioBtnYes.png"
        femaleButton?.myAltBtn = [maleButton!]

        
        //Attach text fields to UITextFieldDelegate for hiding the keyboard
//        self.username.delegate = self
//        self.password.delegate = self
//        self.firstName.delegate = self
//        self.lastName.delegate = self
//        self.email.delegate = self
//        self.confirmPassword.delegate = self
    }
    
    func updateBdayTextField(sender: UIDatePicker){
        BDayTextField.text = dateFormat.stringFromDate(sender.date)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        _ = (BDayTextField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        BDayPicker.hidden = false
        if(clickCounter == 0){
            clickCounter += 1
        }
        else{
            BDayPicker.hidden = true
            clickCounter = 0
        }
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //HIDE KEYBOARD
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
