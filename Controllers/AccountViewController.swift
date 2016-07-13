//
//  AccountViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 27/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//
import UIKit
/*
class AccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var accountArray = NSMutableArray()
    let profileArray = NSMutableArray()
    @IBOutlet var openSideBar: UIBarButtonItem!

    
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
        cell?.accessoryType = .DisclosureIndicator
        return cell!
    }
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedRow = indexPath.row
        switch selectedRow
        {
        case 0:
            print("Profile Selected")
            let userProfile = QBSession.currentSession().currentUser!
            profileArray.addObject(userProfile)
            print(profileArray)
            
            
        case 1:
            print("Settings Selected")
            
        case 2:
            print("Logout Selected")
            QBRequest.logOutWithSuccessBlock({ (_) in
                print("Logout")
                }, errorBlock: { (_) in
                    print("Error Occur")
            })
            let login = self.storyboard?.instantiateViewControllerWithIdentifier("login") as? LoginViewController
            self.presentViewController(login!, animated: true, completion: nil)
        default:
            print("Default case")
            
            
        }
    }
}
*/

 
 
 
class AccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    var accountArray = NSMutableArray()
    var profileArray = NSMutableArray()
@IBOutlet var openSideBar: UIBarButtonItem!
 /// The number of elements in the data source
 var total = 0
 
 /// The identifier for the parent cells.
 let parentCellIdentifier = "ParentCell"
 
 /// The identifier for the child cells.
 let childCellIdentifier = "ChildCell"
 
 /// The data source
 var dataSource: [Parent]!
 
 /// Define wether can exist several cells expanded or not.
 let numberOfCellsExpanded: NumberOfCellExpanded = .One
 
 /// Constant to define the values for the tuple in case of not exist a cell expanded.
 let NoCellExpanded = (-1, -1)
 
 /// The index of the last cell expanded and its parent.
 var lastCellExpanded : (Int, Int)!
    
    var selectedParent:String?
    var newElement:Parent?
 override func viewDidLoad() {
 super.viewDidLoad()
    _ = self.revealViewController
    self.openSideBar.target = self.revealViewController()
    self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    accountArray = ["Profile","Settings","Logout"]
    self.setInitialDataSource(numberOfRowParents: 3, numberOfRowChildPerParent: 5)
    self.lastCellExpanded = NoCellExpanded
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 }
 
 /**
 Set the initial data for test the table view.
 
 - parameter parents: The number of parents cells
 - parameter childs:  Then maximun number of child cells per parent.
 */
 private func setInitialDataSource(numberOfRowParents parents: Int, numberOfRowChildPerParent childs: Int) {
 
 // Set the total of cells initially.
 self.total = parents
 
 let data = [Parent](count: parents, repeatedValue: Parent(state: .Collapsed, childs: [String](), title: ""))
 
 dataSource = data.enumerate().map({ (index: Int, element: Parent) -> Parent in
 
  newElement = element
 
// newElement.title = "Item \(index)"
    newElement!.title = accountArray.objectAtIndex(index) as! String
 
 // generate the random number between 0...childs
  // let random = Int(arc4random_uniform(UInt32(childs + 1)))
   
   
 // create the array for each cell
 // newElement!.childs = (0..<random).enumerate().map {"Subitem \($0.index)"}
    
    let userProfile = QBSession.currentSession().currentUser!
    profileArray.addObject("The ID is:\(userProfile.ID)")
    profileArray.addObject("The UserProfile CreatedAt:\(userProfile.createdAt!)")
    profileArray.addObject("The UserProfile is UpdatedAt:\(userProfile.updatedAt!)")
    profileArray.addObject("The EmailID is:\(userProfile.email!)")
    profileArray.addObject("The LoginID is:\(userProfile.login!)")
    if let swiftArray = profileArray as NSArray as? [String]
    {
        if newElement?.title == "Profile"{
        newElement?.childs = swiftArray
        }
    }
   return newElement!
 })
 }
 
 /**
 Expand the cell at the index specified.
 
 - parameter index: The index of the cell to expand.
 */
 private func expandItemAtIndex(index : Int, parent: Int) {
 
 // the data of the childs for the specific parent cell.
 let currentSubItems = self.dataSource[parent].childs
 
 // update the state of the cell.
 self.dataSource[parent].state = .Expanded
 
 // position to start to insert rows.
 var insertPos = index + 1
 
 let indexPaths = (0..<currentSubItems.count).map { _ -> NSIndexPath in
 let indexPath = NSIndexPath(forRow: insertPos, inSection: 0)
 insertPos += 1
 return indexPath
 }
 
 // insert the new rows
 tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
 
 // update the total of rows
 self.total += currentSubItems.count
 }
 
 /**
 Collapse the cell at the index specified.
 
 - parameter index: The index of the cell to collapse
 */
 private func collapseSubItemsAtIndex(index : Int, parent: Int) {
 
 var indexPaths = [NSIndexPath]()
 
 let numberOfChilds = self.dataSource[parent].childs.count
 
 // update the state of the cell.
 self.dataSource[parent].state = .Collapsed
 
 guard index + 1 <= index + numberOfChilds else { return }
 
 // create an array of NSIndexPath with the selected positions
 indexPaths = (index + 1...index + numberOfChilds).map { NSIndexPath(forRow: $0, inSection: 0)}
 
 // remove the expanded cells
 tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
 
 // update the total of rows
 self.total -= numberOfChilds
 }
 
 /**
 Update the cells to expanded to collapsed state in case of allow severals cells expanded.
 
 - parameter parent: The parent of the cell
 - parameter index:  The index of the cell.
 */
 private func updateCells(parent: Int, index: Int) {
 
 switch (self.dataSource[parent].state) {
 
 case .Expanded:
 self.collapseSubItemsAtIndex(index, parent: parent)
 self.lastCellExpanded = NoCellExpanded
 
 case .Collapsed:
 switch (numberOfCellsExpanded) {
 case .One:
 // exist one cell expanded previously
 if self.lastCellExpanded != NoCellExpanded {
 
 let (indexOfCellExpanded, parentOfCellExpanded) = self.lastCellExpanded
 
 self.collapseSubItemsAtIndex(indexOfCellExpanded, parent: parentOfCellExpanded)
 
 // cell tapped is below of previously expanded, then we need to update the index to expand.
 if parent > parentOfCellExpanded {
 let newIndex = index - self.dataSource[parentOfCellExpanded].childs.count
 self.expandItemAtIndex(newIndex, parent: parent)
 self.lastCellExpanded = (newIndex, parent)
 }
 else {
 self.expandItemAtIndex(index, parent: parent)
 self.lastCellExpanded = (index, parent)
 }
 }
 else {
 self.expandItemAtIndex(index, parent: parent)
 self.lastCellExpanded = (index, parent)
 }
 case .Several:
 self.expandItemAtIndex(index, parent: parent)
 }
 }
 }
 
 /**
 Find the parent position in the initial list, if the cell is parent and the actual position in the actual list.
 
 - parameter index: The index of the cell
 
 - returns: A tuple with the parent position, if it's a parent cell and the actual position righ now.
 */
 private func findParent(index : Int) -> (parent: Int, isParentCell: Bool, actualPosition: Int) {
 
 var position = 0, parent = 0
 guard position < index else { return (parent, true, parent) }
 
 var item = self.dataSource[parent]
 
 repeat {
 
 switch (item.state) {
 case .Expanded:
 position += item.childs.count + 1
 case .Collapsed:
 position += 1
 }
 
 parent += 1
 
 // if is not outside of dataSource boundaries
 if parent < self.dataSource.count {
 item = self.dataSource[parent]
 }
 
 } while (position < index)
 
 // if it's a parent cell the indexes are equal.
 if position == index {
 return (parent, position == index, position)
 }
 
 item = self.dataSource[parent - 1]
 return (parent - 1, position == index, position - item.childs.count - 1)
 }
 }
 
 extension AccountViewController {
 
 // MARK: UITableViewDataSource
 
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 return 1
 }
 
 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return self.total
 }
 
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
 var cell : UITableViewCell!
 
 let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
 
 if !isParentCell {
 cell = tableView.dequeueReusableCellWithIdentifier(childCellIdentifier, forIndexPath: indexPath)
 cell.textLabel!.text = self.dataSource[parent].childs[indexPath.row - actualPosition - 1]
 cell.backgroundColor = UIColor.whiteColor()
 }
 else {
 cell = tableView.dequeueReusableCellWithIdentifier(parentCellIdentifier, forIndexPath: indexPath)
 cell.textLabel!.text = self.dataSource[parent].title
 }
 
 return cell
 }
 
 // MARK: UITableViewDelegate
 
 func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
 let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
    let selectedRow = indexPath.row
    switch selectedRow {
    case 0:
        print("Profile")
      
        
    case 1:
        print("Settings")
    case 2:
        print("Logout")
        QBRequest.logOutWithSuccessBlock({ (_) in
            print("Logout")
            }, errorBlock: { (_) in
                print("Error Occur")
        })
        let login = self.storyboard?.instantiateViewControllerWithIdentifier("login") as? LoginViewController
        self.presentViewController(login!, animated: true, completion: nil)
        
    default:
        print("Default case")
    }
 guard isParentCell else {
 print("A child was tapped!!!")
 
 // The value of the child is indexPath.row - actualPosition - 1
 //print("The value of the child is \(self.dataSource[parent].childs[indexPath.row - actualPosition - 1])")
 
 return
 }
 
 tableView.beginUpdates()
 self.updateCells(parent, index: indexPath.row)
 tableView.endUpdates()
 }
 
func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
 return !self.findParent(indexPath.row).isParentCell ? 44.0 : 64.0
 }
 }

