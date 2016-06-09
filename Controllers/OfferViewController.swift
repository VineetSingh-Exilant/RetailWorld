//
//  FirstViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit

class OfferViewController: UIViewController,UICollectionViewDelegate {

    @IBOutlet weak var openSideBar: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray:NSArray? = NSArray()
    var productNameArray:NSArray? = NSArray()
    var discountArray:NSArray? = NSArray()

     override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.subviews)
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        Constants.tabCtrl = self.tabBarController!
        
        imageArray = ["image1.jpeg","image2.jpeg","image3.jpeg","image4.jpeg","image5.jpeg","image6.jpeg","image7","image8","image9"]
        
        productNameArray = ["Novels","Electronics","Clothing","Kitchen","Accessories","Novels","Clothing","Electronics","Kitchen"]
        
        discountArray = ["Discount 10%","Discount 23%","Discount 5%","Discount 45%","Discount 33%","Discount 49%","Discount 2%","Discount 9%","Discount 70%"]
        
}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var ctrls =  Constants.tabCtrl.viewControllers! as [ UIViewController]
        if ctrls.count > 4
        {
            ctrls.removeAtIndex(0)
            self.tabBarController?.setViewControllers(ctrls, animated: true)
           
        }
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return (imageArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let identifier:String = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! OfferCollectionViewCell
        cell.productName.text = ""
        cell.discountsOnProducts.text = discountArray?.objectAtIndex(indexPath.row) as? String
        discountArray?.objectAtIndex(indexPath.row) as? String
        
    cell.descriptionOfProduct.text = ""
        
        let recipeImg:UIImageView? = cell.viewWithTag(100) as? UIImageView
        cell.productImage.image = UIImage(named:"recipeImg" )
        recipeImg?.image = UIImage(named:imageArray!.objectAtIndex(indexPath.row) as! String)
        return cell
        
    }


}

