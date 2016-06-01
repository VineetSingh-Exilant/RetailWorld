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
    var offer = OfferViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome To Retail World"
         categoryArray = ["Food", "Beauty & Care", "Stationery", "Fruits & Vegetables"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = categoryArray.objectAtIndex(indexPath.row) as? String
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedRow = indexPath.row
        switch selectedRow {
        case 0:
            let foodController = self.storyboard?.instantiateViewControllerWithIdentifier("Food") as? FoodViewController
            self.presentViewController(foodController!, animated:true, completion:nil)
           // self.tableView.addSubview(customView)
            print("Hello")
        default:
            print("Default Case")
        }
    }
}