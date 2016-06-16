//
//  LoginAlerts.swift
//  RetailWorld
//
//  Created by Pratibha Sawargi on 08/06/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class LoginAlerts: NSObject
{
    
 class func showAlertWithMessage(title:String,message:String,controller : UIViewController)
    {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title:title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title:"Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            })
            alertController.addAction(action)
            controller.presentViewController(alertController, animated: true, completion: nil)

        } else {
            // Fallback on earlier versions
        }
               }
    
}



