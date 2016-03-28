//
//  SignUpController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/27/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet var CreateButton: UIButton!
    @IBOutlet var BDayTextField: UITextField!
    @IBOutlet var BDayDatePicker: UIDatePicker!
    
    @IBOutlet var MaleBtn: DownStateButton?
    @IBOutlet var FemaleBtn: DownStateButton?
    
    
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
