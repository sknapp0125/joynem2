//
//  joynemLibrary.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/28/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import Foundation
import UIKit

//Radial button code
class DownStateButton : UIButton {
    
    var myAltBtn:Array<DownStateButton>?
    var downStateImage:String? = "radioBtnYes.png"{
        
        didSet{
            if downStateImage != nil {
                self.setImage(UIImage(named: downStateImage!), forState: UIControlState.Selected)
            }
        }
    }
    
    func unselectedAlternateButtons() {
        if myAltBtn != nil {
            self.selected = true
            
            for aBtn:DownStateButton in myAltBtn! {
                aBtn.selected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        unselectedAlternateButtons()
        super.touchesBegan(touches, withEvent: event)
    }
    
    func toggleButton() {
        if self.selected == false {
            self.selected = true
        } else {
            self.selected = false
        }
    }
    
}