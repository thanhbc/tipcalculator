//
//  ViewController.swift
//  TipCalc
//
//  Created by Ban ChinhThanh on 2/22/16.
//  Copyright © 2016 coderschool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    @IBOutlet weak var billLabel: UILabel!
    
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    
    var tipPercentages: [Double] = []
    
    var keep: Bool = false
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var moneySymbol: String = ""
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                initSegmented()
        animateItem()
        billField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEdittingChanged(sender: AnyObject) {
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipAmount = billAmount * tipPercentage
        let total = billAmount + tipAmount
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
//        let langId = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
//        let countryId = NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
//        let language = "\(langId)-\(countryId)"
//        NSLocale(localeIdentifier: language)
        formatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = formatter.stringFromNumber(tipAmount)
            totalLabel.text = formatter.stringFromNumber(total)
    }
    
    
    @IBAction func onTapped(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    
    func initSegmented(){
        checkDefaulsValue("good_service", defaultValue: 0.22)
        checkDefaulsValue("normal_service", defaultValue: 0.2)
        checkDefaulsValue("bad_service", defaultValue: 0.18)

    }
    
    func checkDefaulsValue(key: String,defaultValue: Double){
        if defaults.doubleForKey(key) == 0{
            defaults.setDouble(defaultValue, forKey: key)
        }
    }

    
    func animateItem(){
        UIView.animateWithDuration(0.5, animations: {
            self.billLabel.center.x += self.view.bounds.width
            self.billField.center.x += self.view.bounds.width

        })
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
            self.tipLabel.center.x += self.view.bounds.width
             self.tipTextLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: [], animations: {
            self.totalTextLabel.center.x += self.view.bounds.width
            self.totalLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, options: [], animations: {
            self.tipControl.center.x += self.view.bounds.width
        
            }, completion: nil)
        
        billField.becomeFirstResponder()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getTipsPercentages()
        moneySymbol = getCurrencySymbol()
        tipControl.setTitle(String(format: "%.0f", tipPercentages[0] * 100) + "%", forSegmentAtIndex: 0)
        tipControl.setTitle(String(format: "%.0f", tipPercentages[1] * 100) + "%", forSegmentAtIndex: 1)
        tipControl.setTitle(String(format: "%.0f", tipPercentages[2] * 100) + "%", forSegmentAtIndex: 2)
        
        
        if keep != true {
            tipLabel.center.x  -= view.bounds.width
            billField.center.x -= view.bounds.width
            billLabel.center.x -= view.bounds.width
            totalLabel.center.x -= view.bounds.width
            tipControl.center.x -= view.bounds.width
            tipTextLabel.center.x -= view.bounds.width
            totalTextLabel.center.x -= view.bounds.width
            tipLabel.text = "\(moneySymbol)"
            totalLabel.text = "\(moneySymbol)"
        }
      
        
        print("view will appear")
    }
    
    func getTipsPercentages(){
         tipPercentages = [defaults.doubleForKey("bad_service"), defaults.doubleForKey("normal_service"),defaults.doubleForKey("good_service")  ]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        keep = true
        print("view did disappear")
    }
    
    func getCurrencySymbol() -> String {
//        let langId = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
//        let countryId = NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
//        let language = "\(langId)-\(countryId)"
//        print(language)

        let pre = NSLocale.preferredLanguages()[0]
        let locale = NSLocale(localeIdentifier: pre)
//        NSLocale.currentLocale()
//        print(locale)
        
//        NSLocale(localeIdentifier: language as String)
        let symbol = locale.objectForKey(NSLocaleCurrencySymbol) as? String
//        print(symbol)

        return symbol!

}
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         billField.resignFirstResponder()
        return true
    }
}

