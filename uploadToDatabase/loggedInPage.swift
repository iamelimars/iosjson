//
//  loggedInPage.swift
//  uploadToDatabase
//
//  Created by Elisha J Marshall III on 8/14/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class loggedInPage: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    override func viewDidLoad() {
        
        
        
    }
   
    override func viewDidAppear(animated: Bool) {
        let myId = NSUserDefaults.standardUserDefaults().valueForKey("userID") as! String
        idLabel.text = myId
    }
    @IBAction func logOutPressed(sender: AnyObject) {
        
        for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        performSegueWithIdentifier("LogOut", sender: self)
        
    }

}
