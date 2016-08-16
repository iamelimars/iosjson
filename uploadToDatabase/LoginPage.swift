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
    override func viewDidAppear(animated: Bool) {
        if let myId = NSUserDefaults.standardUserDefaults().valueForKey("userID") as? String {
            print("My ID = \(myId)")
        } else {
            
            print("noID")
        }
        
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        
        if (emailTextField.text == "" || passwordTextfield.text == "") {
            
            alertView("Try Again", myMessage: "Please enter an email and password")
            
        } else {
            
            getData()
            
        }
        
        
        
        
        performSegueWithIdentifier("toLoggedInPage", sender: self)
        
        
    }
    func getData() {
        
        let email = emailTextField.text! as String
        let password = passwordTextfield.text! as String
        
        let newEmail = email.stringByReplacingOccurrencesOfString("@", withString: "%40")
        //let url = NSURL(string:"http://iamelimars.com/userslogin.php?email=\(newEmail)&password=\(password)&submit=Submit")
        let url = NSURL(string: "http://iamelimars.com/userslogin.php?")
        let request = NSMutableURLRequest(URL: url!)
        let postString = "email=\(newEmail)&password=\(password)&submit=Log%20In"
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            func displayError(error: String) {
                
                print(error)
                
            }
            if error == nil {
                guard let data = data else {
                    
                    displayError("No data was returned from the request")
                    return
                    
                }
                
            }
            
            let res = response as! NSHTTPURLResponse
            
            print(res.statusCode)
            
            print("response= \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("ResponseString = \(responseString)")
            self.extract_json(data!)
            
        }
        task.resume()
        
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
    
    func extract_json(jsonData:NSData) {
        
        
        
        
        let result: AnyObject
        
        do {
            result = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                        
            
            
            
            
            if let myNewResults = result["users"] as? NSArray {
                //print(myNewResults)
                guard let myResults = myNewResults[0] as? [String:AnyObject] else {
                    print("errorrrr")
                return}
                
                //print(myResults)
                let person = Person()
                person.username = myResults["username"] as! String
                person.id = myResults["id"] as! String
                let userID = myResults["id"] as! String
                
                print(person.id)
                print(person.username)
                
                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "userID")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let myId = NSUserDefaults.standardUserDefaults().valueForKey("userID") as! String
                print("myID: \(myId)")
                
            
            }
            
            /*
            for jsonResults in myResults {
                
                let person = Person()
                person.username = jsonResults["username"] as! String
                //person.password = jsonResults["password"] as! String
                //person.email = jsonResults["email"] as! String
                //person.id = jsonResults["id"] as! NSInteger
                print(person.username)
                
                //self.people.append(person)
            }
            */
            
        }  catch {
            print(error)
            
            print("Could not parse the data as JSON")
            return
            
        }
        
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
