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
    var offer = OfferViewController()
    var categoryArray = NSMutableArray()
    var gadgetsyArray = NSMutableArray()
   
    
    var selectedSection:Int?
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
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
            str = "Grocery"
        }
        else if section == 1
        {
            str = "Electronics"
        }else
        {
            print("other case")
        }
        return str
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
      
      
        let food = storyboard?.instantiateViewControllerWithIdentifier("NavFood") as? UINavigationController
       var ctrls =  Constants.tabCtrl.viewControllers! as [ UIViewController]
       var FirstCtrl =  ctrls[0]
       FirstCtrl = food!
        //ctrls.removeFirst()
        
        ctrls.insert(FirstCtrl, atIndex: 0)
        Constants.tabCtrl.viewControllers = ctrls
        Constants.tabCtrl.tabBar.items![0].title = "Food"
        Constants.tabCtrl.selectedIndex = 0
        self.revealViewController().rightRevealToggleAnimated(true)
        
       

       /* self.revealViewController().rightRevealToggleAnimated(true)
        tableView.reloadData()
        let selecteRow = indexPath.row
        if indexPath.section == 0{
        switch selecteRow {
        case 0:
            let food = storyboard?.instantiateViewControllerWithIdentifier("Food") as? FoodViewController
            self.presentViewController(food!, animated: true, completion: nil)
        default:
            print("Default Case")
        }
            
        }*/
        
    }
    
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }

    
}