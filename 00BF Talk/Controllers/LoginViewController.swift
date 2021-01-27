//
//  LoginViewController.swift
//  00BF Talk
//
//  Created by Jenny Woorim Lee on 2020/12/11.
//

import UIKit
import Firebase

class LoginViewController : UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                } else {
                    self?.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
              // ...
        }
        
        }
        
    }
}
