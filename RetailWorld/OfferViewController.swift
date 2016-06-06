//
//  FirstViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit


class OfferViewController: UIViewController,SideBarViewControllerDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var openSideBar: UIBarButtonItem!
    var selectedMenuItem:Int?
   
    @IBOutlet var customView: UIView!
    var itemsArray = [FoodItems]()
     override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.subviews)
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        customView.hidden = false
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

//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        let foodController = self.storyboard?.instantiateViewControllerWithIdentifier("Food") as? FoodViewController
//        self.presentViewController(foodController!, animated:true, completion:nil)
//        self.view.addSubview((foodController?.view!)!)
        
        
        
    }
<<<<<<< Updated upstream
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
=======
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        print("Coming")
>>>>>>> Stashed changes

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func acceptData(data: Int?) {
        selectedMenuItem = data!
        print("The value is \(selectedMenuItem!)")
        displayView()
    }
func displayView()
{
   
    
    print("displayView")
    print(selectedMenuItem)
    if (selectedMenuItem != nil){
    switch selectedMenuItem!
    {
    case 0:
        let foodController = self.storyboard?.instantiateViewControllerWithIdentifier("offer") as? OfferViewController
        self.presentViewController(foodController!, animated:true, completion:nil)
        self.view.addSubview((foodController?.view!)!)
        
          self.customView.hidden = false
          self.tableView.reloadData()

        
        
    default:
        print("default Case")
    }
    }

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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsArray.count
        
    }
  
}

