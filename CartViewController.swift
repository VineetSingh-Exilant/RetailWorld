//
//  ChartViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 27/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var itemsArray = [FoodItems]()
   
    @IBOutlet var tableView: UITableView!
    @IBOutlet var openSideBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        QBRequest.objectsWithClassName("cart", successBlock: { (_, items) in
            for item in items!{
                let foodObject = item as! QBCOCustomObject
                var eachItem = FoodItems()
                eachItem.name = foodObject.fields?.objectForKey("Name") as? String
                eachItem.fileId = foodObject.fields?.objectForKey("FileID") as? UInt
                eachItem.price = foodObject.fields?.objectForKey("Price") as? Double
                eachItem.itemCreatedBy = foodObject.userID
                eachItem.quantity = foodObject.fields?.objectForKey("Quantity") as? Double
                self.itemsArray.append(eachItem)
                print(self.itemsArray.count)
               self.tableView.reloadData()
               self.reloadBadgeNumber()
            }
            
        }) { (_) in
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let foodItem = itemsArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FoodTableViewCell
        cell.accessoryType = .None
        cell.foodName.text = foodItem.name!
        cell.foodPrice.text = String(foodItem.price!)
        cell.foodQuantity.text = String(foodItem.quantity!)
        QBRequest.downloadFileWithID(foodItem.fileId!, successBlock: { (_, data) in
            
            print(data)
            
            cell.foodImage.image = UIImage(data: data)
            
            }, statusBlock: { (_, _) in
                
                
        }) { (_) in
            
        }
        return cell
    }
    func reloadBadgeNumber(){
        if(self.itemsArray.count > 0){

            self.navigationController?.tabBarItem.badgeValue = String(itemsArray.count)
        }else{
            self.navigationController?.tabBarItem.badgeValue = nil
        }
    }
}
