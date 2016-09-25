//
//  TipState.swift
//  TipTacToe
//
//  Created by Ankush Agrawal on 9/24/16.
//  Copyright © 2016 Ankush Agrawal. All rights reserved.
//

import Foundation

class TipState: NSObject {
    var billValue: Double;
    var tipPercent: Double;
    var totalValue: Double;
    var timeStamp: NSDate;
    
    init(billValue:Double = 0.0, tipPercent:Double = 0.0, totalValue:Double = 0.0) {
        self.billValue = billValue
        self.tipPercent = tipPercent
        self.totalValue = totalValue
        if (totalValue != (1.0+tipPercent/100.0)*billValue) {
            print ("Invalid Params")
        }
        self.timeStamp = NSDate()
    }
    
    init(coder aDecoder: NSCoder!) {
        self.billValue = aDecoder.decodeObject(forKey: "billValue") as! Double
        self.tipPercent = aDecoder.decodeObject(forKey: "tipPercent") as! Double
        self.totalValue = aDecoder.decodeObject(forKey: "totalValue") as! Double
        self.timeStamp = aDecoder.decodeObject(forKey: "timeStamp") as! NSDate
    }
    
    func initWithCoder(aDecoder: NSCoder) -> TipState {
        self.billValue = aDecoder.decodeObject(forKey: "billValue") as! Double
        self.tipPercent = aDecoder.decodeObject(forKey: "tipPercent") as! Double
        self.totalValue = aDecoder.decodeObject(forKey: "totalValue") as! Double
        self.timeStamp = aDecoder.decodeObject(forKey: "timeStamp") as! NSDate
        return self
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encode(billValue, forKey: "billValue")
        aCoder.encode(tipPercent, forKey: "tipPercent")
        aCoder.encode(totalValue, forKey: "totalValue")
        aCoder.encode(timeStamp, forKey: "timeStamp")
    }
    
}
