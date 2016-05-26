//
//  FoodViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 24/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var itemsArray = [FoodItems]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        QBRequest.objectsWithClassName("Food", successBlock: { (_, items) in
            for item in items!{
                let foodObject = item as! QBCOCustomObject
                let eachItem = FoodItems()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let foodItem = itemsArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FoodTableViewCell
        tableView.allowsMultipleSelection = true
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsArray.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("Selected Row is:\(indexPath.row)")
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let selectedRow = tableView.indexPathForSelectedRow
        if (selectedRow != nil){
        cell!.accessoryType = .Checkmark
        }else
        {
            cell!.accessoryType = .None
        }
        

    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = .None
    }
    }

