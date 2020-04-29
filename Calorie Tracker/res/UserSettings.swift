//
//  UserSettings.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/28/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation

class UserSettings {
    let KEY_CALORIES: String = "CalorieTrackerUserGoal"
    
    var calorieGoal: Int {
        let storedCalorieGoal = UserDefaults.standard.integer(forKey: KEY_CALORIES)
        
        return storedCalorieGoal
    }
    
    init() {
        if calorieGoal == 0 {
            setCalorieGoal(2000)
        }
    }
    
    func setCalorieGoal(_ calories: Int) {
        UserDefaults.standard.setValue(calories, forKey: KEY_CALORIES)
    }
}
