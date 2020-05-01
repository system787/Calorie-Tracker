//
//  OptionsViewController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var goalTextField: UITextField!
    
    let userSettings = UserSettings()
    let mealController = MealController()
    
    override func viewDidLoad() {
        goalTextField.delegate = self
    }
    
    @IBAction func setCalorieGoalButtonPressed(_ sender: UIButton) {
        goalTextField.resignFirstResponder()
        
        if let text = goalTextField.text {
            if !text.isEmpty {
                userSettings.setCalorieGoal(Int(text) ?? 2000)
            } else {
                let alert = UIAlertController(title: "Error", message: "Calorie goal must not be empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func resetTodayButtonPressed(_ sender: UIButton) {
        for meal in mealController.todayMeals {
            mealController.moveToHistory(meal)
        }
        
        let alert = UIAlertController(title: "Success", message: "Finished migrating today's meals to history", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
