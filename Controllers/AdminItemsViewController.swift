//
//  AdminItemsViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 05/07/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit
import MobileCoreServices
class AdminItemsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var removeItemsTableView: UITableView!
    @IBOutlet weak var descriptionsView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    var newMedia: Bool?
    var itemName:[String] = []
    var itemPrice:[Int] = []
    var itemID:[UInt] = []
    var selectedRowItems:Int?
    var imageData:NSData?
    var cellData:NSData?
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        showView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func takePicture(sender: AnyObject)
    {
                    if UIImagePickerController.isSourceTypeAvailable(
                        UIImagePickerControllerSourceType.Camera) {
        
                        let imagePicker = UIImagePickerController()
        
                        imagePicker.delegate = self
                        imagePicker.sourceType =
                            UIImagePickerControllerSourceType.Camera
                        imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                        imagePicker.allowsEditing = false
        
                        self.presentViewController(imagePicker, animated: true,
                                                   completion: nil)
                       newMedia = true
    }
    }
    @IBAction func cameraRolls(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true,
                                       completion: nil)
            newMedia = false
            
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // if mediaType.isEqualToString(kUTTypeImage as! String)
        if mediaType == (kUTTypeImage as String)
        {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
              let compressedImage = self.resizeImage(image, width: 4, height: 4)
            
              imageData = UIImagePNGRepresentation(compressedImage)
              myImageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(AdminItemsViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType == (kUTTypeMovie as String)
            {
                // Code to support video here
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Save Failed",
                                              message: "Failed to save image",
                                              preferredStyle: UIAlertControllerStyle.Alert)
            } else {
                // Fallback on earlier versions
            }
            
            if #available(iOS 8.0, *) {
                let cancelAction = UIAlertAction(title: "OK",
                                                 style: .Cancel, handler: nil)
            } else {
                // Fallback on earlier versions
            }
            
            //alert!.addAction(cancelAction)
            if #available(iOS 8.0, *) {
                self.presentViewController(alert!, animated: true,
                                           completion: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemName.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = self.itemName[indexPath.row]
        cell?.detailTextLabel?.text = "Price:\(self.itemPrice[indexPath.row])"
//        if let data = cellData
//        {
//        cell?.imageView?.image = UIImage(data: data)
//        }else{
//            var image : UIImage = UIImage(named: "defaultImage.jpg")!
//            cell!.imageView!.image = image
//        }
    
     
        let image : UIImage = UIImage(named: "defaultImage.jpg")!
        cell!.imageView!.image = image
        let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        dispatch_async(backgroundQueue, { QBRequest.downloadFileWithID(self.itemID[indexPath.row], successBlock: { (_, data) in
            dispatch_async(dispatch_get_main_queue()) {
            cell?.imageView!.image = UIImage(data: data)
                cell?.imageView?.contentMode = .ScaleToFill
            }
            }, statusBlock: { (_, _) in
                
        }) { (_) in
            
            }})
        

        return cell!
    }
    @IBAction func backAction(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func showView()
    {
        switch selectedRowItems!
        {
        case 0:

            print("")
        case 1:
            removeItemsTableView.frame.size.height = self.view.frame.size.height
            removeItemsTableView.frame.size.width = self.view.frame.size.width 
            removeItemsTableView.frame.origin.y = self.view.frame.origin.y + 40
            self.view.addSubview(removeItemsTableView)
            QBRequest.objectsWithClassName("Items", successBlock: { (_, items) in
                for item in items!{
                    let itemObjects = item as! QBCOCustomObject
                    self.itemName.append((itemObjects.fields?.objectForKey("Name") as? String)!)
                    self.itemPrice.append((itemObjects.fields?.objectForKey("Price") as? Int)!)
                    self.itemID.append((itemObjects.fields?.objectForKey("FileID") as? UInt)!)
//                    for index in 0...self.itemID.count - 1 {
//                        QBRequest.downloadFileWithID(self.itemID[index], successBlock: { (_, data) in
//                            self.cellData = data
//                            print(self.cellData)
//                            self.removeItemsTableView.reloadData()
//                            
//                            }, statusBlock: { (_, _) in
//                                
//                                
//                        }) { (_) in
//                            
//                        }
//
//                    }
                   
                    self.removeItemsTableView.reloadData()
                }
                
            }) { (_) in
                
            }
            
        case 2:
            print("Edit case")
        case 3:
            print("Item Stock")
        case 4:
          print("Logout")
           
          
            
        default:
            print("Default Case")
        }
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        itemName.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    @IBAction func uploadItem(sender: AnyObject)
    {
        QBRequest.TUploadFile(imageData!, fileName: "ItemImage", contentType: "image/png", isPublic: false, successBlock: { (_, blob) in
        let itemObject = QBCOCustomObject()
        itemObject.className = "Items"
        itemObject.fields!.setValue(self.nameTextField.text, forKey: "Name")
        itemObject.fields!.setValue(Float(self.priceTextField.text!), forKey: "Price")
        itemObject.fields!.setValue(self.descriptionsView.text, forKey: "Descriptions")
        itemObject.fields!.setValue(Float(self.quantityTextField.text!), forKey: "Quantity")
        itemObject.fields!.setValue(blob.ID, forKey: "FileID")
        QBRequest.createObject(itemObject, successBlock: { (_, _) in
            print("Uploaded")
            }, errorBlock: { (_) in
                print("Error Occurred")
        })
        print("ImageID is:\(blob.ID)")
        }, statusBlock: { (_, _) in
        }, errorBlock: { (_) in
        })
    }
   
func resizeImage(image:UIImage,width:CGFloat,height:CGFloat)->UIImage
{
let rect = CGRectMake(0, 0, image.size.width/width, image.size.height/height)
UIGraphicsBeginImageContext(rect.size)
image.drawInRect(rect)
let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
let compressedImageData = UIImageJPEGRepresentation(resizedImage, 1)
let image = UIImage(data:compressedImageData!)!
return image
}
}
