//
//  ThirdViewController.swift
//  BasicLoginApp
//
//  Created by Furkan Kozmaç on 30.01.2023.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var myAnswer = ""
    var myPassword = ""
    
    @IBOutlet weak var securityAnswer: UITextField!
    @IBOutlet weak var passwordArea: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func onClick(_ sender: Any) {
        
        if securityAnswer.text == myAnswer {
            passwordArea.text = "Your password is: " + myPassword
        }else{
            passwordArea.text = "Answer is incorrect."
        }
        
    }
    
    
    
    

  

}
