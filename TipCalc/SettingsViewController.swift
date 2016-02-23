//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Ban ChinhThanh on 2/22/16.
//  Copyright © 2016 coderschool. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var normalTextField: UITextField!
    @IBOutlet weak var goodTextField: UITextField!
    @IBOutlet weak var badTextField: UITextField!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       initTexFieldValue()
    }
    func initTexFieldValue(){
        goodTextField.text = String(format: "%.0f",defaults.doubleForKey("good_service") * 100)
        normalTextField.text = String(format: "%.0f",defaults.doubleForKey("normal_service") * 100)
        badTextField.text = String(format: "%.0f",defaults.doubleForKey("bad_service") * 100)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetTips(sender: AnyObject) {
        defaults.setDouble(0.18, forKey: "bad_service")
        defaults.setDouble(0.2, forKey: "normal_service")
        defaults.setDouble(0.22, forKey: "good_service")
        initTexFieldValue()
        view.endEditing(true)

    }
    @IBAction func onTapped(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        if let badValue:NSString = (badTextField.text! as NSString) {
              defaults.setDouble(badValue.doubleValue / 100, forKey: "bad_service")
        }
        if let normalValue:NSString = (normalTextField.text! as NSString) {
            defaults.setDouble(normalValue.doubleValue / 100, forKey: "normal_service")
        }
        if let goodValue:NSString = (goodTextField.text! as NSString) {
            defaults.setDouble(goodValue.doubleValue / 100, forKey: "good_service")
        }
        
        self.navigationController?.popViewControllerAnimated(true)
       }
  
}
