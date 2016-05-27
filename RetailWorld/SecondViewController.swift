//
//  SecondViewController.swift
//  ExampleTabBar
//
//  Created by Pratibha Sawargi on 26/05/16.
//  Copyright © 2016 Pratibha Sawargi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {


    
    @IBOutlet weak var sideBar: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = self.revealViewController
        self.sideBar.target = self.revealViewController()
        self.sideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
   
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

