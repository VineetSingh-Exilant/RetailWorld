//
//  SecondViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var itemsArray = [FoodItems]()
    @IBOutlet weak var sideBar: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.revealViewController
        self.sideBar.target = self.revealViewController()
        self.sideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //Constants.tabCtrl = self.tabBarController!
        QBRequest.objectsWithClassName("Favorites", successBlock: { (_, items) in
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

}

