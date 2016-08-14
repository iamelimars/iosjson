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
    //
    var TableData = [Dictionary<String,AnyObject>]()
    var Table: [Dictionary<String,AnyObject>] = [Dictionary<String,AnyObject>]()
    var tableName = [String]()
    var tableID = [String]()
    
    var people = [Person]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        //print(Table)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        do_table_refresh()
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

}
