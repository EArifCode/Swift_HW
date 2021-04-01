//
//  ViewController.swift
//  WeatherApp
//
//  Created by Elena on 31.03.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        
        if  usernameTextField.text == "Elena",
            passwordTextField.text == "12345" {
            print("Auth's successed")
        }
        else {
            print("Auth's denied")
        }
    }
    
}

