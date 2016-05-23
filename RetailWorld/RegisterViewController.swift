//
//  RegisterViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 23/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var emailID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

   
    @IBAction func register(sender: AnyObject)
    {
        if password.text! != confirmPassword.text!
        {
            let alert = UIAlertController(title: "Password", message: "Password MisMatch", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: nil)
         let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
            
            
        }else{
           
            let user = QBUUser()
            user.login = userName.text
            user.password = password.text
            user.email = emailID.text
            QBRequest.signUp(user, successBlock: { (response, retrievedUser) -> Void in
            print(user)
            print("Registered")
            self.dismissViewControllerAnimated(true, completion: nil)
            
          })
          { (errorResponse) -> Void in
            print("Error Occur")
            }
           }
        }
    }

