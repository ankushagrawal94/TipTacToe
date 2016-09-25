//
//  SettingsViewController.swift
//  TipTacToe
//
//  Created by Ankush Agrawal on 9/21/16.
//  Copyright © 2016 Ankush Agrawal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentSC: UISegmentedControl!
    @IBOutlet weak var themeSelectorSC: UISegmentedControl!
    let colorSchemes: [NSString] = ["light", "dark"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.synchronize()
        
        let selectedIndex = defaults.integer(forKey: "selectedIndex")
        tipPercentSC.selectedSegmentIndex = selectedIndex

        let selectedTheme = defaults.string(forKey: "colorScheme")
        themeSelectorSC.selectedSegmentIndex = selectedTheme == "dark" ? 1 : 0
        
        if selectedTheme == "light" {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 47.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.lightGray
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.darkGray
        }

    }
    
    @IBAction func defaultTipPercentChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercentSC.selectedSegmentIndex, forKey: "selectedIndex")
        defaults.synchronize()
    }

    @IBAction func themeSelected(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let selectedTheme = colorSchemes[themeSelectorSC.selectedSegmentIndex]
        defaults.set(colorSchemes[themeSelectorSC.selectedSegmentIndex], forKey: "colorScheme")
        defaults.synchronize()
        
        if selectedTheme == "light" {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 47.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.lightGray
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.darkGray
        }

    }
}
