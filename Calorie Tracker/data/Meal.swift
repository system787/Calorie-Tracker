//
//  Meal.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit

struct Meal: Codable, Equatable {
    var mealName: String
    var mealCalories: Int
    var mealImage: Data?
    
    init(_ mealName: String, _ mealCalories: Int, _ mealImage: UIImage) {
        self.mealName = mealName
        self.mealCalories = mealCalories
        
        if let data = mealImage.pngData() {
            self.mealImage = data
        }
    }
}
