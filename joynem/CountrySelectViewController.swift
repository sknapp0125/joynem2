//
//  CountrySelectViewController.swift
//  joynem
//
//  Created by Stefanie Knapp on 3/31/16.
//  Copyright © 2016 Stefanie Knapp. All rights reserved.
//

import UIKit

class CountrySelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var countryPicker: UIPickerView!
    @IBOutlet var countryText: UITextField!
    var country = ["U.S.", "Canada", "Costa Rica", "Argentina", "Cuba"]
    
    
    @IBOutlet var statePicker: UIPickerView!
    @IBOutlet var stateText: UITextField!
    var state = [ "AK - Alaska",
                  "AL - Alabama",
                  "AR - Arkansas",
                  "AS - American Samoa",
                  "AZ - Arizona",
                  "CA - California",
                  "CO - Colorado",
                  "CT - Connecticut",
                  "DC - District of Columbia",
                  "DE - Delaware",
                  "FL - Florida",
                  "GA - Georgia",
                  "GU - Guam",
                  "HI - Hawaii",
                  "IA - Iowa",
                  "ID - Idaho",
                  "IL - Illinois",
                  "IN - Indiana",
                  "KS - Kansas",
                  "KY - Kentucky",
                  "LA - Louisiana",
                  "MA - Massachusetts",
                  "MD - Maryland",
                  "ME - Maine",
                  "MI - Michigan",
                  "MN - Minnesota",
                  "MO - Missouri",
                  "MS - Mississippi",
                  "MT - Montana",
                  "NC - North Carolina",
                  "ND - North Dakota",
                  "NE - Nebraska",
                  "NH - New Hampshire",
                  "NJ - New Jersey",
                  "NM - New Mexico",
                  "NV - Nevada",
                  "NY - New York",
                  "OH - Ohio",
                  "OK - Oklahoma",
                  "OR - Oregon",
                  "PA - Pennsylvania",
                  "PR - Puerto Rico",
                  "RI - Rhode Island",
                  "SC - South Carolina",
                  "SD - South Dakota",
                  "TN - Tennessee",
                  "TX - Texas",
                  "UT - Utah",
                  "VA - Virginia",
                  "VI - Virgin Islands",
                  "VT - Vermont",
                  "WA - Washington",
                  "WI - Wisconsin",
                  "WV - West Virginia", 
                  "WY - Wyoming"]
    
    @IBOutlet var cityPicker: UIPickerView!
    @IBOutlet var cityText: UITextField!
    var city = ["Miami", "Chicago", "New York", "Los Angeles", "Seattle"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        self.stateText.inputView = statePicker
        
        self.countryPicker.delegate = self
        self.countryPicker.delegate = self
        self.countryText.inputView = countryPicker
        
        self.cityPicker.delegate = self
        self.cityPicker.delegate = self
        self.cityText.inputView = cityPicker
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
        return state.count
        } else if pickerView == countryPicker {
        return country.count
        } else {
        return city.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePicker {
        return state[row]
        } else if pickerView == countryPicker {
        return country[row]
        } else {
        return city[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
        stateText.text = state[row]
        print(state[row])
        } else if pickerView == countryPicker {
        
        countryText.text = country[row]
        print(country[row])
        } else {
        
        cityText.text = city[row]
        print(city[row])
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
