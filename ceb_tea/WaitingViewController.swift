//
//  WaitingViewController.swift
//  ceb_tea
//
//  Created by tayfun biyikoglu on 08/02/15.
//  Copyright (c) 2015 tayfun biyikoglu. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func checkUserVerification(sender: UIButton) {
        if PFUser.currentUser() != nil {
            
            var query = PFQuery(className:"UserDetail")
            query.whereKey("user", equalTo: PFUser.currentUser())
            
            query.getFirstObjectInBackgroundWithBlock {
                (userDetail: PFObject!, error: NSError!) -> Void in
                if error == nil {
                    // The find succeeded.
                    NSLog("Successfully retrieved \(userDetail.objectId) user detail.")
                    
                    
                    var userVerified = userDetail.objectForKey("isVerified") as NSString
                    println(userVerified)
                    
                    if(userVerified == "1"){
                        self.performSegueWithIdentifier("jumpToHomeFromWaiting", sender: self)
                        println("User is verified")
                    }else{
                        println("Still not verified")                    }
                    
                }else{
                    println(error)
                }
                
            }
            
        }
        
    }

}
