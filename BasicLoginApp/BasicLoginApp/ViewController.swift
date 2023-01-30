//
//  ViewController.swift
//  BasicLoginApp
//
//  Created by Furkan Kozmaç on 30.01.2023.
//

import UIKit

class ViewController: UIViewController {
        
    let username = "furkan"
    let password = "apple123"
    let favouriteColour = "purple"
    
    @IBOutlet weak var myUsername: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var checkPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginOnClick(_ sender: Any) {
        if myUsername.text == username && myPassword.text == password {
            checkPassword.text = "Password is correct."
            performSegue(withIdentifier: "openSecondVC", sender: nil)
        }else {
            checkPassword.text = "Password is incorrect."
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toThirdVC" {
            let destinationVC = segue.destination as! ThirdViewController
            destinationVC.myAnswer = favouriteColour
            destinationVC.myPassword = password
        }
    }
    
    @IBAction func unwindFromCWithSegue(segue: UIStoryboardSegue) {
       // Unwind to here from an another scene.
    }
}

