//
//  GroupTypeSelectViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/31/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class GroupTypeSelectViewController: UIViewController {
    
    @IBOutlet var allTypesSwitch: UISwitch!
    @IBAction func allTypesPressed(sender: AnyObject) {
    }
    
    @IBOutlet var couplesSwitch: UISwitch!
    @IBAction func couplesPressed(sender: AnyObject) {
    }
    
    @IBOutlet var singlesSwitch: UISwitch!
    @IBAction func singlesPressed(sender: AnyObject) {
    }
    
    @IBOutlet var familiesSwitch: UISwitch!
    @IBAction func familiesPressed(sender: AnyObject) {
    }
    
    @IBOutlet var malesSwitch: UISwitch!
    @IBAction func malesPressed(sender: AnyObject) {
    }
    
    @IBOutlet var femalesSwitch: UISwitch!
    @IBAction func femalesPressed(sender: AnyObject) {
    }
    
    @IBOutlet var LGBTSwitch: UISwitch!
    @IBAction func LGBTPressed(sender: AnyObject) {
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
