//
//  AccountViewController.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 27/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet var openSideBar: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.revealViewController
        self.openSideBar.target = self.revealViewController()
        self.openSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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

}
