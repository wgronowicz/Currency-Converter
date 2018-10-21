//
//  ViewController.swift
//  Currency Converter
//
//  Created by Wojciech Gronowicz on 17/10/2018.
//  Copyright © 2018 Wojciech Gronowicz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
   
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var topCurrencySelector: UITextField!
    @IBOutlet weak var bottomCurrencySelector: UITextField!
    
    private let thePicker = UIPickerView()
    private let secondPicker = UIPickerView()
    
    private let currenciesList = ["AUD","CAD","EUR","GBP","JPY","PLN","USD"]
    private let currencyModel = CurrencyModel()
    
    @IBAction func NumberButtonClicked(_ sender: Any) {
        
        if let buttonTitle = (sender as AnyObject).title(for: .normal) {
            
            if (inputLabel.text?.count)! < 9 {
                if inputLabel.text == "0" {
                    
                    if buttonTitle == "."{
                        inputLabel.text = "0."
                    }else if buttonTitle != "0"{
                        inputLabel.text = buttonTitle
                        updateOutputlabel()
                    }
                    
                }else {
                    
                    if buttonTitle == "." && !(inputLabel.text?.contains("."))! {
                        inputLabel.text = inputLabel.text! + buttonTitle
                    } else if buttonTitle != "." {
                        inputLabel.text = inputLabel.text! + buttonTitle
                        updateOutputlabel()
                    }
                }
            }
        }
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        
        if (sender as AnyObject).tag == 3 || ((sender as AnyObject).tag == 4 && inputLabel.text?.count == 1) {
            inputLabel.text = "0"
            outputLabel.text = "0"
        }else if (sender as AnyObject).tag == 4 && inputLabel.text != "0" {
            inputLabel.text!.remove(at: inputLabel.text!.index(before: inputLabel.text!.endIndex))
            updateOutputlabel()
        }
    }
    
    @IBAction func swapButtonClicked(_ sender: Any) {
        
        let helpVar = topCurrencySelector.text
        topCurrencySelector.text = bottomCurrencySelector.text
        bottomCurrencySelector.text = helpVar
        
        updateOutputlabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topCurrencySelector.contentHorizontalAlignment = .center
        bottomCurrencySelector.contentHorizontalAlignment = .center
        topCurrencySelector.inputView = thePicker
        bottomCurrencySelector.inputView = secondPicker
        thePicker.delegate = self
        secondPicker.delegate = self
        inputLabel.adjustsFontSizeToFitWidth = true
        inputLabel.numberOfLines = 1
        inputLabel.minimumScaleFactor = 0.5
        outputLabel.adjustsFontSizeToFitWidth = true
        outputLabel.numberOfLines = 1
        outputLabel.minimumScaleFactor = 0.5
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updateOutputlabel() {
        let num = Double(inputLabel.text!)! * currencyModel.getMultiplyer(from: topCurrencySelector.text!, to: bottomCurrencySelector.text!)
        let num2 = Double(round(num*100)/100)
        
        if floor(num2) == num2 {
            outputLabel.text = String(Int(num2))
        }else {
            outputLabel.text = String(num2)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesList.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currenciesList[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if pickerView == thePicker {
            topCurrencySelector.text = currenciesList[row]
//            topCurrencySelector.resignFirstResponder()
            updateOutputlabel()
        } else if pickerView == secondPicker{
            bottomCurrencySelector.text = currenciesList[row]
//            bottomCurrencySelector.resignFirstResponder()
            updateOutputlabel()
        }
        self.view.endEditing(true)
    }
}

