//
//  ViewController.swift
//  00BF Talk
//
//  Created by Jenny Woorim Lee on 2020/12/11.
//

import UIKit
import CLTypingLabel


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "#00BF Talk"
        
    }

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
}

