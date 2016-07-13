//
//  AdminViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 30/06/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit
import MobileCoreServices
class AdminViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let adminItems:[String] = ["Upload Items","Remove Items","Edit Items","Items Stock","Logout"]
    var newMedia: Bool?
    var selectedRow:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return adminItems.count
     }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = adminItems[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
         selectedRow = indexPath.row
          if let adminItemsController = storyboard!.instantiateViewControllerWithIdentifier("AdminItems") as? AdminItemsViewController {
            adminItemsController.selectedRowItems = selectedRow
            if selectedRow == 4
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let login = self.storyboard?.instantiateViewControllerWithIdentifier("login") as? LoginViewController
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentViewController(login!, animated: true, completion: nil)
                })
            }else{
            presentViewController(adminItemsController, animated: true, completion: nil)
        }
        }
        
    }
}
