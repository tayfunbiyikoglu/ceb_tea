//
//  RequestsViewController.swift
//  ceb_tea
//
//  Created by tayfun biyikoglu on 08/02/15.
//  Copyright (c) 2015 tayfun biyikoglu. All rights reserved.
//

import UIKit

class RequestsViewController: UITableViewController  {
    
    var usernames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("I am here")
        
        var getWaitingRequestsQuery = PFQuery(className: "UserDetail")
        getWaitingRequestsQuery.whereKey("isVerified", equalTo: "0")
        getWaitingRequestsQuery.includeKey("user")
        getWaitingRequestsQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                println(objects[0])
                
                for object in objects {
                    
                  var user = object["user"] as PFObject
                    
                    self.usernames.append(user["username"] as NSString)

                    self.tableView.reloadData()
                    
                    
                }
                
            }else{
                println(error)
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usernames.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 227
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var myCell:RequestTableCell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as RequestTableCell
        
        myCell.username.text = usernames[indexPath.row]
        
        return myCell
        
    }
    
    

}
