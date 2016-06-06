
//
//  AccountViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 27/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var openSideBar: UIBarButtonItem!
    var login = LoginViewController()
    var accountArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        accountArray = ["Profile","Settings","Logout"]
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
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
        return accountArray.count
   }
    

    
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
   {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = accountArray.objectAtIndex(indexPath.row) as! String
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedRow = indexPath.row
        switch selectedRow
        {
        case 0:
            print("Profile Pressed")
        case 1:
            print("Settings")
        case 2:
            print("Logut Pressed")
            QBRequest.logOutWithSuccessBlock({ (_) in
              self.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.pushViewController(self.login, animated: true)
                }, errorBlock: { (_) in
                    
            })
        default:
            print("default case")
        }
    }
}
