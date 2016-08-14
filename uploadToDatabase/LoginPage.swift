//
//  LoginPage.swift
//  uploadToDatabase
//
//  Created by Elisha J Marshall III on 8/14/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class LoginPage: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        
        self.emailTextField.delegate = self
        self.passwordTextfield.delegate = self
        
        
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        //http://iamelimars.com/login.php?email=testtt%40test.com&password=Password&submit=Submit
        let url = NSURL(string: "http://iamelimars.com/userlogin.php")
        let request = NSURLRequest(URL: url!)
        
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
