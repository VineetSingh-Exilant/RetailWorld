//
//  SideBarViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var customView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var categoryArray = NSMutableArray()
    var gadgetsyArray = NSMutableArray()
    var offer = OfferViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome To Retail World"
         categoryArray = ["Food", "Beauty & Care", "Stationery", "Fruits & Vegetables"]
         gadgetsyArray = ["iPhone", "MacBook Pro", "Mac Mini", "iMac"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section == 0
        {
          return categoryArray.count
        }
        else
        {
          return gadgetsyArray.count
        }
     
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if indexPath.section == 0
        {
        cell.textLabel!.text = categoryArray.objectAtIndex(indexPath.row) as? String
        }
        else{
        cell.textLabel!.text = gadgetsyArray.objectAtIndex(indexPath.row) as? String
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var str = ""
        if section == 0
        {
            str = "Kitchen"
        }
        else
        {
            str = "Electronics"
        }
        return str
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.revealViewController().rightRevealToggleAnimated(true)
                
    }
    
    
}