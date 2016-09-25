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

        if let selectedTheme = defaults.string(forKey: "colorScheme") {
            themeSelectorSC.selectedSegmentIndex = selectedTheme == "dark" ? 1 : 0
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if let selectedTheme = defaults.string(forKey: "colorScheme") {
            loadTheme(selectedTheme: selectedTheme)
        }
        
    }
    
    @IBAction func defaultTipPercentChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercentSC.selectedSegmentIndex, forKey: "selectedIndex")
        defaults.synchronize()
    }

    @IBAction func themeSelected(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(colorSchemes[themeSelectorSC.selectedSegmentIndex], forKey: "colorScheme")
        defaults.synchronize()
        
        if let selectedTheme = defaults.string(forKey: "colorScheme") {
            loadTheme(selectedTheme: selectedTheme)
        }

    }
    
    func loadTheme(selectedTheme: String) {
        if selectedTheme == "light" {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 41.0/255, green: 217.0/255, blue: 194.0/255, alpha: 1.0)
            navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] = UIColor.black
            self.view.backgroundColor = UIColor(red: 1.0/255, green: 162.0/255, blue: 166.0/255, alpha: 1.0)
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 47.0/255, green: 41.0/255, blue: 51.0/255, alpha: 1.0)
            navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] = UIColor.white
            self.view.backgroundColor = UIColor(red: 47.0/255, green: 41.0/255, blue: 51.0/255, alpha: 1.0)
        }
        
        if let navFont = UIFont(name: "Papyrus", size: 26.0) {
            navigationController?.navigationBar.titleTextAttributes?[NSFontAttributeName] = navFont
        }

    }
}
