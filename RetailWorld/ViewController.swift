//
//  ViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 18/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit
import Quickblox
class ViewController: UIViewController {

      var response = QBResponse()
     var errorResponse = QBResponse()
      var objects = QBCOCustomObject()
//    var page = QBResponsePage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        QBRequest.logInWithUserLogin("ajay", password: "12345678", successBlock: { (_, user) in
            
            print(user?.fullName)
            print(user?.email)
            
            QBRequest.objectsWithClassName("UserName", successBlock: {(response,someObject) -> Void in print(response)
                
                print(someObject?.count)
                
                }, errorBlock: {(errorResponse) -> Void in print(errorResponse.description)
            
            })
            
            
            }) { (_) in
                
               print("Error")
        }
        
        
        QBRequest.downloadFileWithID(4447910, successBlock: { (_, fileData) in
            
            print(fileData)
            
            }, statusBlock: { (_, _) in
                
                
            }) { (_) in
                
        }
        
        
//        var object = QBCOCustomObject()
//        object.className = "Movies"
//        // your Class name
//        // Object fields
//        object.fields?.setValue("Star Wars", forKey: "name")
//        object.fields?.setValue(9.1, forKey: "rating")
//        object.fields?.setValue(false, forKey: "documentary")
//        object.fields?.setValue("fantasy", forKey: "genre")
//        object.fields?.setValue("Star Wars is an American epic space opera franchise consisting of a film series created by George Lucas.", forKey: "descriptions")
//       QBRequest.createObject(object, successBlock: {(response, object)  in
//            // do something when object is successfully created on a server
//        print("Success")
//            }, errorBlock: {(errorResponse) in
//                // error handling
//                print( errorResponse.error!.description)
//        })
        
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

