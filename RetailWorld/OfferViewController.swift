//
//  FirstViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit

class OfferViewController: UIViewController {

    @IBOutlet weak var openSideBar: UIBarButtonItem!

     override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.subviews)
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        Constants.tabCtrl = self.tabBarController!
        
}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var ctrls =  Constants.tabCtrl.viewControllers! as [ UIViewController]
        if ctrls.count > 4
        {
            
            //Constants.tabCtrl.tabBar.items![0].title = nil
            //Constants.tabCtrl.tabBar.items?.removeFirst()
            ctrls.removeAtIndex(0)
            self.tabBarController?.setViewControllers(ctrls, animated: true)
           
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

