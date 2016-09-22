//
//  ViewController.swift
//  TipTacToe
//
//  Created by Ankush Agrawal on 9/21/16.
//  Copyright © 2016 Ankush Agrawal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var tipPercentSC: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = UserDefaults.standard
        defaults.synchronize()
        let selectedIndex = defaults.integer(forKey: "selectedIndex")
        tipPercentSC.selectedSegmentIndex = selectedIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 47.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
    }

    @IBAction func onScreenTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func tipPercentValueChanged(_ sender: AnyObject) {
        calculateAndDisplayTip()
    }
    
    @IBAction func billTextChanged(_ sender: AnyObject) {
        moveTextViewUp()
        calculateAndDisplayTip()
    }
    
    func calculateAndDisplayTip() {
        let percents: Array = [10, 15, 20]
        let tipPercentage: Int = percents[tipPercentSC.selectedSegmentIndex]
        if billTextField.text! != "" {
            let tipValue: Double = Double (tipPercentage) * Double (billTextField.text!)! / 100
            let billValue: Double = Double (billTextField.text!)!
            tipValueLabel.text = String(format: "$%.2f", tipValue)
            totalValueLabel.text = String(format: "$%.2f", tipValue + billValue)
        }
    }
    
    func moveTextViewUp() {
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
            self.billTextField.frame.origin.y -= 100
        }, completion: { finished in
            print("Text Field animated!")
        })
    }
}

