//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Furkan Kozmaç on 27.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstValueInput: UITextField!
    @IBOutlet weak var secondValueInput: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sumValues(_ sender: Any) {
        
        if let firstValue = Int(firstValueInput.text!), let secondValue = Int(secondValueInput.text!) {
            let calculationResult = firstValue + secondValue
            result.text = String(calculationResult)
        }else {
            result.text = "Value is invalid."
        }
        
    }
    
    @IBAction func substractValues(_ sender: Any) {
        
        if let firstValue = Int(firstValueInput.text!), let secondValue = Int(secondValueInput.text!) {
            let calculationResult = firstValue - secondValue
            result.text = String(calculationResult)
        }else {
            result.text = "Value is invalid."
        }
        
    }
    
    @IBAction func multiplyValues(_ sender: Any) {
        
        if let firstValue = Int(firstValueInput.text!), let secondValue = Int(secondValueInput.text!) {
            let calculationResult = firstValue * secondValue
            result.text = String(calculationResult)
        }else {
            result.text = "Value is invalid."
        }

        
    }
    
    @IBAction func divideValues(_ sender: Any) {
        
        if let firstValue = Int(firstValueInput.text!), let secondValue = Int(secondValueInput.text!) {
            if firstValue == 0 && secondValue == 0 {
                result.text = "I can't do that."
            }else{
            let calculationResult = firstValue / secondValue
            result.text = String(calculationResult)
            }
        }else {
            result.text = "Value is invalid."
        }

        
    }
    

    
}

