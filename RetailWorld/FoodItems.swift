//
//  FoodItems.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 26/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

//class FoodItems: NSObject {
//    var itemId:String?
//    var itemCreatedBy:UInt?
//    var fileId:UInt?
//    var name:String?
//    var price:Double?
//    var quantity:Double?
//    override init() {
//        itemId = ""
//        itemCreatedBy = 0
//        fileId = 0
//        name = ""
//        price = 0.0
//        quantity = 0.0
//        super.init()
//        
//    }
    struct FoodItems
    {
        var itemId:String?
        var itemCreatedBy:UInt?
        var fileId:UInt?
        var name:String?
        var price:Double?
        var quantity:Double?
        init ()
        {
            itemId = ""
            itemCreatedBy = 0
            fileId = 0
            name = ""
            price = 0.0
            quantity = 0.0
           
        }
    }
//}
