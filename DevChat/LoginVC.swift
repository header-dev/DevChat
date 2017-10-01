//
//  LoginVC.swift
//  DevChat
//
//  Created by kritawit bunket on 9/19/2560 BE.
//  Copyright © 2560 headerdevs. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailField:RoundTextField!
    @IBOutlet weak var passwordField:RoundTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginPressed(_ sender: Any){
        if let email = emailField.text, let pass = passwordField.text ,(email.characters.count > 0 && pass.characters.count > 0)  {
            
            AuthService.instance.login(email: email, password: pass, onComplete: { (errMsg,data) in
                guard errMsg == nil else{
                    let aler = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    aler.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(aler, animated: true, completion: nil)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
            
        }else{
            
            let alert = UIAlertController(title: "Username & Password Required", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
    }
}
