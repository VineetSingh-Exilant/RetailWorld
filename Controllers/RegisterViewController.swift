//
//  RegisterViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 23/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit
import DigitsKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var mobileNo: UITextField!
    @IBOutlet var emailID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailID.attributedPlaceholder = NSAttributedString(string:"Enter EmailID",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        password.attributedPlaceholder = NSAttributedString(string:"Enter Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        mobileNo.attributedPlaceholder = NSAttributedString(string:"Enter Mobile No.",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        confirmPassword.attributedPlaceholder = NSAttributedString(string:"Confirm Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func register(sender: AnyObject)
    {
        if password.text! != confirmPassword.text!
        {
            let alert = UIAlertController(title: "Password", message: "Password MisMatch", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: nil)
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
        }
            else if !isValidEmail(emailID.text!)
            {
                let alert = UIAlertController(title: "Email", message: "Wrong Email.", preferredStyle: .Alert)
                self.presentViewController(alert, animated: true, completion: nil)
                let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
                alert.addAction(cancelAction)
            }
            
            
        else{
            
            let digits = Digits.sharedInstance()
            digits.logOut()
            let configuration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
            let theme = DGTAppearance()
            theme.bodyFont = UIFont.systemFontOfSize(17)
            theme.labelFont = UIFont.systemFontOfSize(17)
            theme.accentColor = UIColor.blueColor()
            theme.backgroundColor = UIColor.whiteColor()
            
            configuration.appearance = theme
            configuration.phoneNumber = self.mobileNo.text!
            digits.authenticateWithViewController(self, configuration:configuration, completion: { (ses, err) in
                if err == nil{
                    print(ses)
                    print(ses.userID)
                    
                    let user = QBUUser()
                    user.phone = self.mobileNo.text
                    user.password = self.password.text
                    user.login = self.mobileNo.text
                    user.email = self.emailID.text
                    user.twitterDigitsID = ses.userID
                    QBRequest.signUp(user, successBlock: { (response, retrievedUser) -> Void in
                        print(user)
                        print("Registered")
                        let alert = UIAlertController(title: "Registration", message: "Registration done successfully", preferredStyle: .Alert)
                        self.presentViewController(alert, animated: true, completion: nil)
                        let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
                        alert.addAction(cancelAction)
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        })
                    { (errorResponse) -> Void in
                        print("Error Occur")
                    }
                    
                    
                    
                }else{
                    
                    print("error is \(err.localizedDescription)")
                }
                
            })
            
            
            
            //            let user = QBUUser()
            //            user.phone = self.mobileNo.text
            //            user.password = self.password.text
            //            user.email = self.emailID.text
            //            QBRequest.signUp(user, successBlock: { (response, retrievedUser) -> Void in
            //            print(user)
            //            print("Registered")
            //                let alert = UIAlertController(title: "Registration", message: "Registration done successfully", preferredStyle: .Alert)
            //                self.presentViewController(alert, animated: true, completion: nil)
            //                let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
            //                alert.addAction(cancelAction)
            //            self.dismissViewControllerAnimated(true, completion: nil)
            //
            //          })
            //          { (errorResponse) -> Void in
            //            print("Error Occur")
            //            }
            
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
}
}
