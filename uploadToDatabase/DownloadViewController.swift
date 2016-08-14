//
//  DownloadViewController.swift
//  uploadToDatabase
//
//  Created by iMac on 8/12/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class DownloadViewController: UITableViewController {
    
    //var jsonResult:Array = []
    var TableData = [Dictionary<String,AnyObject>]()
    var Table: [Dictionary<String,AnyObject>] = [Dictionary<String,AnyObject>]()
    var tableName = [String]()
    var tableID = [String]()
    
    var people = [Person]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.iamelimars.com/jsonreceive.php")
        
        let request = NSMutableURLRequest(URL: url!)
        

        
        getData()
        //print(Table)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        do_table_refresh()
    }
    struct User {
        let id: Int
        let username: String
        let email: String
    }
    func getUser(request: NSURLRequest, callback: (User) -> ()) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, urlResponse, error in
            //var jsonErrorOptional: NSError?
            let jsonOptional: AnyObject!
            do {
            jsonOptional = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
            } catch {
                
                print(error)
                return
            }
            if let json = jsonOptional as? Dictionary<String, AnyObject> {
                if let id = json["id"] as AnyObject? as? Int { // Currently in beta 5 there is a bug that forces us to cast to AnyObject? first
                    if let name = json["username"] as AnyObject? as? String {
                        if let email = json["email"] as AnyObject? as? String {
                            let user = User(id: id, username: name, email: email)
                            print(user)
                            callback(user)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    func getData () {
        
        
        let url = NSURL(string: "http://www.iamelimars.com/jsonreceive.php")
        
        let request = NSMutableURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            func displayError(error: String) {
                
                print(error)
                
            }
            if error == nil {
                guard let data = data else {
                    
                    displayError("No data was returned from the request")
                    return
                    
                }
                self.extract_json(data)
                /*
                 let result: AnyObject!
                 
                 do {
                 result = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                 }  catch {
                 
                 print("Could not parse the data as JSON")
                 return
                 
                 }
                 
                 
                 
                 //self.jsonResults = result as? NSArray
                 if let jsonResults = result as? NSArray {
                 self.jsonResult = jsonResults
                 print(self.jsonResult)
                 print("success")
                 
                 }
                 */
                
                
                
            }
            
        }
        task.resume()
        
    }
    func extract_json(jsonData:NSData) {
        
        let result: AnyObject!
        
        do {
            result = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as! [[String:AnyObject]]
            guard let myResults = result as? [[String:AnyObject]] else { return }
            for jsonResults in myResults {
                
                let person = Person()
                person.username = jsonResults["username"] as! String
                person.password = jsonResults["password"] as! String
                person.email = jsonResults["email"] as! String
                //person.id = jsonResults["id"] as! NSInteger
                
                self.people.append(person)
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
            
            
            
        }  catch {
            
            print("Could not parse the data as JSON")
            return
            
        }
        
        
        /*
        if let users = result as? NSArray {
            //Table = users as! [Dictionary<String, AnyObject>]
            //print(Table)
            
            
            for (var i = 0; i < users.count ; i++ ) {
                
                if let obj = users[i] as? NSDictionary
                {
                    for objects in obj {
                        
                        let person = Person()
                        print(objects)
                        //person.username = objects["username"] as! AnyObject
                        //person.email = objects["email"] as! String
                        //person.id = objects["id"] as! String
                        
                        
                        
                    }
                    //TableData.append(obj as! Dictionary<String, AnyObject>)
                    
                    //print(obj)
                    
                }
                
            }
            
            
        }
        do_table_refresh();
        */
    }
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! downloadCell
        
        //let user = jsonResults[indexPath.row] as? [String: AnyObject]
        //let username = user!["username"] as! String
        //print(self.result[indexPath.row])
        //print(TableData)
        let person = people[indexPath.row]
        cell.usernameLabel.text = person.username
        cell.passwordLabel.text = person.password
        cell.emailLabel.text = person.email
        //cell.idLabel.text = "\(person.id)"
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
