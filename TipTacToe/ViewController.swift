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

    let percents: Array = [10, 15, 20]
    var hasTextMovedUpFlag: Bool = false
    let currencyFormatter = NumberFormatter()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = UserDefaults.standard
        defaults.synchronize()

        let selectedIndex = defaults.integer(forKey: "selectedIndex")
        tipPercentSC.selectedSegmentIndex = selectedIndex
        
        
        let colorScheme = defaults.string(forKey: "colorScheme")
        if colorScheme == "light" {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 47.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.lightGray
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255, green: 206.0/255, blue: 255.0/255, alpha: 1.0)
            self.view.backgroundColor = UIColor.darkGray
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadState()
        
        currencyFormatter.locale = NSLocale.current
        currencyFormatter.numberStyle = .currency
        
        let tipText = tipValueLabel.text!.replacingOccurrences(of: "$", with: "")
        let totalText = totalValueLabel.text!.replacingOccurrences(of: "$", with: "")
        
        let tipValue: NSNumber = NSNumber(value:(Double)(tipText)!)
        let totalValue: NSNumber = NSNumber(value:(Double)(totalText)!)
        
        tipValueLabel.text = currencyFormatter.string(from: tipValue)
        totalValueLabel.text = currencyFormatter.string(from: totalValue)
        
        billTextField.becomeFirstResponder()
    }

    @IBAction func onScreenTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func tipPercentValueChanged(_ sender: AnyObject) {
        calculateAndDisplayTip()
    }
    
    @IBAction func billTextChanged(_ sender: AnyObject) {
        if (!hasTextMovedUpFlag){
            moveTextViewUp()
            hasTextMovedUpFlag = true
        }
        calculateAndDisplayTip()
    }
    
    func calculateAndDisplayTip() {
        let tipPercentage: Int = self.percents[tipPercentSC.selectedSegmentIndex]
        if billTextField.text! != "" {
            let tipValue = Double (tipPercentage) * Double (billTextField.text!)! / 100
            let billValue = Double (billTextField.text!)!
            
            let tipValueNumber = NSNumber(value:tipValue)
            let totalValueNumber = NSNumber(value:billValue+tipValue)
            
            tipValueLabel.text = currencyFormatter.string(from: (tipValueNumber))
            totalValueLabel.text = currencyFormatter.string(from: (totalValueNumber))
            saveState()
        }
    }
    
    func moveTextViewUp() {
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
            self.billTextField.frame.origin.y -= 100
        }, completion: { finished in
            print("Text Field animated!")
        })
    }
    
    func saveState() {
        let defaults = UserDefaults.standard
        let billValue: Double = Double (billTextField.text!)!
        let tipPercent: Double = Double (self.percents[tipPercentSC.selectedSegmentIndex])
        let totalValue: Double = (1.0+tipPercent/100.0)*billValue
        let tipState = TipState(billValue: billValue, tipPercent: tipPercent, totalValue: totalValue)
        
        let encodedBillValue = NSKeyedArchiver.archivedData(withRootObject: tipState.billValue) as NSData
        let encodedTipPercent = NSKeyedArchiver.archivedData(withRootObject: tipState.tipPercent) as NSData
        let encodedTotalValue = NSKeyedArchiver.archivedData(withRootObject: tipState.totalValue) as NSData
        let encodedTimeStamp = NSKeyedArchiver.archivedData(withRootObject: tipState.timeStamp) as NSData
        let encodedArray: [NSData] = [encodedBillValue, encodedTipPercent, encodedTotalValue, encodedTimeStamp]
        
        defaults.set(encodedArray, forKey: "tipState")
    }
    
    func loadState() {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        
        if let tipStateEncoded: [NSData] = (defaults.object(forKey: "tipState") as? [NSData]) {
            let unpackedTimeStamp = NSKeyedUnarchiver.unarchiveObject(with: (tipStateEncoded[3] as NSData) as Data) as! NSDate
            let currentTime: Date = NSDate() as Date
            
            let unpackedBillValue = NSKeyedUnarchiver.unarchiveObject(with: (tipStateEncoded[0] as NSData) as Data) as! Double
            let unpackedTipPercent = NSKeyedUnarchiver.unarchiveObject(with: (tipStateEncoded[1] as NSData) as Data) as! Double
            let unpackedTotalValue = NSKeyedUnarchiver.unarchiveObject(with: (tipStateEncoded[2] as NSData) as Data) as! Double

            // Check if the last saved state is less than 10 minutes old
            if (unpackedTimeStamp.compare(currentTime.addingTimeInterval((-60*10))) == ComparisonResult.orderedDescending) {
                billTextField.text = (String) (unpackedBillValue)
                tipValueLabel.text = (String) (unpackedTipPercent * unpackedBillValue / 100.0)
                totalValueLabel.text = (String) (unpackedTotalValue)
            }
        } else {
            tipValueLabel.text = (String) (0)
            totalValueLabel.text = (String) (0)
        }
    }
}

