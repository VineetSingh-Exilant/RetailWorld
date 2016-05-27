//
//  FoodTableViewCell.swift
//  RetailWorld
//
//  Created by Vineet Kumar Singh on 26/05/16.
//  Copyright © 2016 Vineet Kumar Singh. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var foodQuantityStepper: UIStepper!
    @IBOutlet var foodQuantity: UILabel!
    @IBOutlet var foodPrice: UILabel!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var foodImage: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func stepperAction(sender: AnyObject)
    {
        foodQuantity.text = String(foodQuantityStepper.value)
        totalPrice.text = String(Double(foodPrice.text!)! * Double(foodQuantity.text!)!)
    }
    
}
