//
//  LoginViewController.swift
//  ceb_tea
//
//  Created by tayfun biyikoglu on 07/02/15.
//  Copyright (c) 2015 tayfun biyikoglu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var alreadyRegistered: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpToggleButton: UIButton!

    
    var signupActive = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func toggleSignUp(sender: AnyObject) {
        
        if signupActive == true {

            signupActive = false
            signUpButton.setTitle("Sign In", forState: UIControlState.Normal)
            alreadyRegistered.text = "Not Registered?"
            signUpToggleButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
        } else {
            
            signupActive = true
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadyRegistered.text = "Already Registered?"
            signUpToggleButton.setTitle("Sign In", forState: UIControlState.Normal)
            
        }
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textFiled: UITextField) -> Bool {
        textFiled.resignFirstResponder()
        return true
    }
    
    
    @IBAction func signUp(sender: UIButton) {
        
        var error = ""
        
        if username.text == "" || password.text == "" {
            error = "Please enter a username and password"
        }
        
        if error != "" {
            displayAlert("Error In Form", error: error)
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool!, signupError: NSError!) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil  {
                        
                       var userDetail = PFObject(className: "UserDetail")
                        
                        userDetail["isAdmin"] = "0"
                        userDetail["isVerified"] = "0"
                        userDetail["user"] = user
                        userDetail.saveInBackgroundWithBlock {
                        (succeeded: Bool!, error: NSError!) -> Void in
                            self.activityIndicator.stopAnimating()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()

                        }
                        
                        self.performSegueWithIdentifier("jumpToWaiting", sender: "self")
                        
                        
                    } else {
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            error = errorString
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Sign Up", error: error)
                        
                    }
                }
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
                    (user: PFUser!, signupError: NSError!) -> Void in
                    
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil {
                        
                        self.performSegueWithIdentifier("jumpToHome", sender: "self")
                        
                        println("Signed In...")
                        
                    } else {
                        
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            error = errorString
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Log In", error: error)
                        
                        
                    }
                }
                
                
            }
            
            
        }
        
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
                        self.performSegueWithIdentifier("jumpToHome", sender: self)
                        println("User is verified")
                    }else{
                       self.performSegueWithIdentifier("jumpToWaiting", sender: self)
                    }
                    
                }else{
                    println(error)
                }

            }
            
        }
        
    }

}
