//
//  ViewController.swift
//  uploadToDatabase
//
//  Created by iMac on 8/11/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextfield.delegate = self
        self.passwordTextfield.delegate = self
        self.emailTextfield.delegate = self
/*
        let url = NSURL(string: "http://www.iamelimars.com/jsonadd.php")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let postString = "username=testUsername&pass=testPassword&email=iosemail@test.com"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if error != nil {
                
                print("error= \(error)")
                return
                
            }
            
            print("response= \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("ResponseString = \(responseString)")
            
        }
        task.resume()
        */
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitButton(sender: AnyObject) {
        
        let username = usernameTextfield.text! as String
        let password = passwordTextfield.text! as String
        let email = emailTextfield.text! as String
        
        let url = NSURL(string: "http://www.iamelimars.com/jsonadd.php")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let postString = "username=\(username)&pass=\(password)&email=\(email)"
        print(postString)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if error != nil {
                
                print("error= \(error)")
                return
                
            }
            
            print("response= \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("ResponseString = \(responseString)")
            
            print("Successfully added user!")
            
            
        }
        task.resume()
        self.alertView("Success!", myMessage: "You have successfully signed up!")
        
        clearTextField()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func alertView(myTitle: String, myMessage: String) {
        
        let alert = UIAlertController(title: myTitle, message:myMessage, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default) { _ in
            // Put here any code that you would like to execute when
            // the user taps that OK button (may be empty in your case if that's just
            // an informative alert)
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
        
    }
    func clearTextField() {
        
        usernameTextfield.text = nil
        passwordTextfield.text = nil
        emailTextfield.text = nil

    }

}

