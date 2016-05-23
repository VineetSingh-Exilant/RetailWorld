//
//  LoginViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 23/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit
import QuickLook
import DigitsKit

class LoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let authButton = DGTAuthenticateButton(authenticationCompletion: { (session: DGTSession?, error: NSError?) in
//            if (session != nil) {
//                // TODO: associate the session userID with your user model
//                let message = "Phone number: \(session!.phoneNumber)"
//                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .Alert)
//                alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: .None))
//                self.presentViewController(alertController, animated: true, completion: .None)
//            } else {
//                NSLog("Authentication error: %@", error!.localizedDescription)
//            }
//        })
//        authButton.center = self.view.center
//        self.view.addSubview(authButton)
        
        

        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func submit(sender: AnyObject)
    {
        let emailString = email.text
        let passwordString = password.text
        QBRequest.logInWithUserEmail(emailString!, password: passwordString!, successBlock: { (_, loginUser) in
            print(loginUser)
            }) { (_) in
                print("Error Occur")
        }
    }
  }
