//
//  ResetPasswordViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 23/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailID: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()

      
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
        let emailString = emailID.text!
        QBRequest.resetUserPasswordWithEmail(emailString, successBlock: { (_) in
            print("Password Change")
            let alert = UIAlertController(title: "Reset Password", message: "Reset Password link is send to your email id", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: nil)
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            
            
        }) { (_) in
            print("Error occur")
        }
    }
}
