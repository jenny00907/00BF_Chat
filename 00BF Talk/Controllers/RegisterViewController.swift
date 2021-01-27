//
//  RegisterViewController.swift
//  00BF Talk
//
//  Created by Jenny Woorim Lee on 2020/12/11.
//

import UIKit
import Firebase

class RegisterViewController : UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                } else {
                    //Naviagate to ChatView
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
                
                
        }
        
        }
    }
}
