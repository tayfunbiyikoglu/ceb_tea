//
//  FirstViewController.swift
//  ceb_tea
//
//  Created by tayfun biyikoglu on 07/02/15.
//  Copyright (c) 2015 tayfun biyikoglu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("First tab viewDidLoad")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func logOut(sender: UIBarButtonItem) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: self)

    }

}

