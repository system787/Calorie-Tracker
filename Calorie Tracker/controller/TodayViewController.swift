//
//  TodayViewController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TodayViewController: UIViewController, AddMealViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var currentLabel: UILabel?
    @IBOutlet var goalLabel: UILabel?
    
    var mealController: MealController = MealController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        calculateCurrentCalories()
        setCalorieGoal()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealController.todayMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TodayViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TodayViewCell else {
            os_log("The dequeued cell was not an instance of TodayViewCell", log: OSLog.default, type: .error)
            fatalError("Fatal error occurred while constructing table view")
        }
        
        cell.meal = mealController.todayMeals[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
    func mealWasAdded(_ meal: Meal) {
        mealController.createToday(meal)
        calculateCurrentCalories()
        tableView.reloadData()
    }
    
    func calculateCurrentCalories() {
        var calories = 0
        for meal in mealController.todayMeals {
            calories += meal.mealCalories
        }
        
        let text = "Current: \(calories) calories"
        currentLabel?.text = text
    }
    
    func setCalorieGoal() {
        let userSettings = UserSettings()
        let goal = userSettings.calorieGoal
        let text = "Goal: \(goal) calories"
        
        goalLabel?.text = text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "addMealSegue":
            guard let addMealViewController = segue.destination as? MealDetailViewController else {
                os_log("Unexpected destination: %@", log: OSLog.default, type: .error, "\(segue.destination)")
                return
            }
            addMealViewController.delegate = self
            
        case "showMealSegue":
            guard let mealDetailViewController = segue.destination as? MealDetailViewController else {
                os_log("Unexpected destination: %@", log: OSLog.default, type: .error, "\(segue.destination)")
                return
            }
            
            guard let selectedViewCell = sender as? TodayViewCell else {
                os_log("Unexpected sender: %@", log: OSLog.default, type: .error, "\(sender ?? "No sender available")")
                return
            }
            
            guard let indexPath = tableView.indexPath(for: selectedViewCell) else {
                os_log("The selected cell is not being displayed by the table", log: OSLog.default, type: .error)
                return
            }
            
            let meal = mealController.todayMeals[indexPath.row]
            
            mealDetailViewController.meal = meal
            mealDetailViewController.delegate = self
            
        default:
            os_log("Unexpected segue identifier: %@", log: OSLog.default, type: .error, "\(segue.identifier ?? "No segue available")")
            return
        }
    }
    
    @IBAction func unwindToToday(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealDetailViewController, let meal = sourceViewController.meal {
            if let indexPath = tableView.indexPathForSelectedRow {
                mealController.updateTodayMeal(mealController.todayMeals[indexPath.row], meal)
            } else {
                if let data = meal.mealImage, let image = UIImage(data: data) {
                    mealController.createToday(meal.mealName, meal.mealCalories, image)
                }
            }
            
            calculateCurrentCalories()
            tableView?.reloadData()
        }
    }
    
    
}
