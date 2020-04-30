//
//  TodayViewCell.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TodayViewCell: UITableViewCell {
    @IBOutlet var mealName: UILabel!
    @IBOutlet var mealCalories: UILabel!
    @IBOutlet var mealImage: UIImageView!
    
    var meal: Meal? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let meal = meal, let image = meal.mealImage else {
            os_log("updateView() called on a null meal object", log: OSLog.default, type: .error)
            return
        }
        
        mealName.text = meal.mealName
        mealCalories.text = String(meal.mealCalories)
        mealImage.image = UIImage(data: image)
    }
}
