//
//  HistoryDetailViewController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit

class HistoryDetailViewController: UIViewController {
    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var mealImageView: UIImageView!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        
        if let meal = meal, let imageData = meal.mealImage {
            navigationItem.title = meal.mealName
            
            let nameText = "Meal Name: \(meal.mealName)"
            mealNameLabel.text = nameText
            
            let caloriesText = "Calories: \(String(meal.mealCalories))"
            caloriesLabel.text = caloriesText
            
            
            mealImageView.image = UIImage(data: imageData)
        }
    }
}
