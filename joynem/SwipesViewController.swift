//
//  SwipesViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/31/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class SwipesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100 ))
        label.text = "Drag Me!"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(SwipesViewController.wasDragged(_:)))
        label.addGestureRecognizer(gesture)
        
        label.userInteractionEnabled = true
        
    }
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        //let yFromCenter = label.center.y - self.view.bounds.height / 2
        
        let xScale = min(100 / abs(xFromCenter), 1)
        //let yScale = min(50 / abs(yFromCenter), 1)
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        var xStretch = CGAffineTransformScale(rotation, xScale, xScale)
        
        label.transform = xStretch
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            if label.center.x < 100 {
                
                print("Not Chosen")
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                print("Chosen")
                
            } else if label.center.y > 100 {
                
                //let yScale = min(50 / abs(yFromCenter), 1)

                print ("Maybe")
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            
            xStretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = xStretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
        
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
