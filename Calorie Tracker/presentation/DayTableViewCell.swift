//
//  DayTableViewCell.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/29/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit

class DayTableViewCell: UITableViewCell {
    @IBOutlet var mealName: UILabel?
    @IBOutlet var calories: UILabel?
    @IBOutlet var mealImage: UIImageView?
    
    var meal: Meal? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let unwrappedMeal = meal {
            mealName?.text = unwrappedMeal.name
            calories?.text = String(unwrappedMeal.calories)
            mealImage?.image = UIImage(data: unwrappedMeal.image!)
        }
    }
}
