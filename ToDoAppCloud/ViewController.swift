//
//  ViewController.swift
//  ToDoAppCloud
//
//  Created by Shengjie Mao on 11/21/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = txtEmail.text else {return}
        guard let password = txtPassword.text else {return}
        
        if email.isEmail == false {
            lblError.text = "Please enter valid email"
            lblError.isHidden = false
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if error != nil {
                strongSelf.lblError.text = error?.localizedDescription
                strongSelf.lblError.isHidden = false
                return
            }
            strongSelf.txtPassword.text = ""
            strongSelf.lblError.isHidden = true
            // we are logged in at this point
            strongSelf.performSegue(withIdentifier: "segueLogin", sender: strongSelf)
        }
    }
    
}

