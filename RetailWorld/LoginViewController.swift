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
        email.attributedPlaceholder = NSAttributedString(string:"Enter your Mobile No.",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        password.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
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
//    let digits = Digits.sharedInstance()
//    let configuration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
//    configuration.phoneNumber = "+918904867753"
//    digits.authenticateWithViewController(nil, configuration: configuration) { session, error in
//        
//        if error != nil{
//            print("error\(error.localizedDescription)")
//        }else{
//            
//            let authSigning = DGTOAuthSigning.init(authConfig:Digits.sharedInstance().authConfig, authSession: session)
//            
//            let headers = authSigning.OAuthEchoHeadersToVerifyCredentials()
//            
//            print("AuthHeadres is \(headers)")
    
            QBRequest.logInWithUserLogin(self.email.text!, password: self.password.text!, successBlock: { (_, user) in
                
                print(user?.email)
                let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as? UITabBarController
                self.navigationController?.pushViewController(tabBarController!, animated: true)
                
                }) { (_) in
                    
                    
    }
    
    
                    
    }
            
//            QBRequest.logInWithTwitterDigitsAuthHeaders(headers, successBlock: { (_, user) in
//                
//                print(user?.fullName)
//                
//                
//                }, errorBlock: { (_) in
//                    
//            })
            
        //}
        
        
   
    
//        let emailString = email.text
//        let passwordString = password.text
//        QBRequest.logInWithUserEmail(emailString!, password: passwordString!, successBlock: { (_, loginUser) in
//            print(loginUser)
//        
//            }) { (_) in
//                print("Error Occur")
//                print("Show error message")
//        }
    
    //}
}