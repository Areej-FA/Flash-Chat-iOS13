//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text , let password = passwordTextfield.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    // give the user feedback to display that thier registerion was unsuccessful and print the issue in thier own langage
                    ProgressHUD.showError(e.localizedDescription)
                } else {
                     // give the user feedback to display that thier registerion was successful
                    ProgressHUD.showSuccess()
                    // Navigate to the ChatViewController
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
            
        }
        
    }
    
}
