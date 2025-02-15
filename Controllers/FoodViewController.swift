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
    var cartObjects = [FoodItems]()
    var cartSelectedRow:Int?
    var favoritesSelectedRow:Int?
    var favObjects = [FoodItems]()
     var fileIdArray = NSMutableArray()
     var fileIDFavArray = NSMutableArray()
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var openSideBar: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.tabBarItem = UITabBarItem(title: "Food", image: nil, selectedImage: nil)
        QBRequest.objectsWithClassName("Food", successBlock: { (_, items) in
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
//    @IBAction func backAction(sender: AnyObject)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsArray.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("Selected Row is:\(indexPath.row)")
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        var selectedRow = tableView.indexPathForSelectedRow
        if (selectedRow != nil){
        cell!.accessoryType = .Checkmark
        }else
        {
            cell!.accessoryType = .None
        }
        cartObjects.append(itemsArray[indexPath.row])
        cartSelectedRow = indexPath.row
        favoritesSelectedRow = indexPath.row
        favObjects.append(itemsArray[indexPath.row])

    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = .None
    }

    @IBAction func cartButtonTapped(sender: AnyObject)
    {
        print("cart Button Tapped")
        
        if let _ = cartSelectedRow{
            let foodSelected = cartObjects[cartSelectedRow!]
            let customObject = QBCOCustomObject()
            customObject.className = "cart"
            customObject.fields?.setValue(foodSelected.fileId, forKey: "FileID")
            customObject.fields?.setValue(foodSelected.name, forKey: "Name")
            customObject.fields?.setValue(foodSelected.quantity, forKey: "Quantity")
            customObject.fields?.setValue(foodSelected.price, forKey: "Price")
            if !fileIdArray.containsObject(foodSelected.fileId!)
            {
                QBRequest.createObject(customObject, successBlock: { (_, _) in
                    print("Succesfully created object")
                    self.fileIdArray.addObject(foodSelected.fileId!)
                    
                }) { (_) in
                    print("error occured")
                    
                }
            }
        }
        
        
    }

    @IBAction func favoritesButtonTapped(sender: AnyObject)
    {
        print("favoritesButtonTapped")
        if let _ = favoritesSelectedRow{
            let favoritesSelected = favObjects[favoritesSelectedRow!]
            let customObject = QBCOCustomObject()
            customObject.className = "Favorites"
            customObject.fields?.setValue(favoritesSelected.fileId, forKey: "FileID")
            customObject.fields?.setValue(favoritesSelected.name, forKey: "Name")
            customObject.fields?.setValue(favoritesSelected.quantity, forKey: "Quantity")
            customObject.fields?.setValue(favoritesSelected.price, forKey: "Price")
            if !(fileIDFavArray.containsObject(isEqual(favoritesSelected.fileId))){
                QBRequest.createObject(customObject, successBlock: { (_, _) in
                    
                    print("Succesfully created object")
                    self.fileIDFavArray.addObject(favoritesSelected.fileId!)
                    
                }) { (_) in
                    
                    print("error occured")
                    
                }
            }
        }
    }
    
    @IBAction func confirmBtnTapped(sender:AnyObject)
    {
       print("confirmBtnTapped")
       
    }
}
