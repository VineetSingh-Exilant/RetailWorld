//
//  LoginViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 23/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit
import QuickLook
//import DigitsKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        email.attributedPlaceholder = NSAttributedString(string:"Enter your Mobile No.",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        password.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
       
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
       self.view.frame.origin.y = -225
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         UIView.animateWithDuration(0.5, delay: 0.4, options: .CurveEaseOut, animations: {
            self.loginButton.alpha = 1
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitt(sender: AnyObject)
    {
       
            let bounds = self.loginButton.bounds
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                self.loginButton.enabled = false
                }, completion: nil)
            
            QBRequest.logInWithUserLogin(self.email.text!, password: self.password.text!, successBlock: { (_, user) in
                
                if self.email.text == "7676842585"{
                    
                    self.registerForAPNS()
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealController = storyBoard.instantiateViewControllerWithIdentifier("Reveal") as! SWRevealViewController
                self.presentViewController(revealController, animated:true, completion:nil)
            }) { (_) in
            }
            
            if self.email.text?.characters.count == 0 || self.password.text?.characters.count == 0
            {
                LoginAlerts.showAlertWithMessage("Login Failed", message: "Please provide correct details", controller: self)
                self.loginButton.enabled = true
            }
        }
    func registerForAPNS()
    {
        
        let application = UIApplication.sharedApplication()
        
        if #available(iOS 8.0, *) {
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
            let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
            
            application.registerUserNotificationSettings(pushNotificationSettings)
            application.registerForRemoteNotifications()
        }else{
            
            let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            application.registerForRemoteNotificationTypes(types)
        }
        
    }


}






