//
//  SideBarViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit
protocol SideBarViewControllerDelegate: class {
    func acceptData(data:Int?)
}
class SideBarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    weak var delegate:SideBarViewControllerDelegate?
    var data:Int?
    @IBOutlet var customView: UIView!
<<<<<<< Updated upstream
=======
    var offer:OfferViewController!
    
    
>>>>>>> Stashed changes
    @IBOutlet weak var tableView: UITableView!
    
    var categoryArray = NSMutableArray()
<<<<<<< Updated upstream
    var gadgetsyArray = NSMutableArray()
    var offer = OfferViewController()
=======
>>>>>>> Stashed changes
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome To Retail World"
         categoryArray = ["Food", "Beauty & Care", "Stationery", "Fruits & Vegetables"]
<<<<<<< Updated upstream
         gadgetsyArray = ["iPhone", "MacBook Pro", "Mac Mini", "iMac"]

=======
        
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        self.revealViewController().rightRevealToggleAnimated(true)
=======
        let selectedRow = indexPath.row
        if offer == nil{
        
            offer = self.storyboard?.instantiateViewControllerWithIdentifier("offer") as! OfferViewController
            self.delegate = offer
        }
        self.delegate?.acceptData(selectedRow)
//        switch selectedRow {
//        case 0:
//            let foodController = self.storyboard?.instantiateViewControllerWithIdentifier("Food") as? FoodViewController
//            self.presentViewController(foodController!, animated:true, completion:nil)
//            self.offerView.view.addSubview((foodController?.view!)!)
//            self.tableView.addSubview(customView)
//            self.revealViewController().rightRevealToggleAnimated(true)
//            print("case 1")
//        default:
//            print("Default Case")
//        }
>>>>>>> Stashed changes
    }
    
}