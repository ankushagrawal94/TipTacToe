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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func defaultTipPercentChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercentSC.selectedSegmentIndex, forKey: "selectedIndex")
        defaults.synchronize()
    }

}
