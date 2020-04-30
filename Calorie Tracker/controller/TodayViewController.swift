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
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "addMealSegue":
            guard let addMealViewController = segue.destination as? AddMealViewController else {
                os_log("Unexpected destination: %@", log: OSLog.default, type: .error, "\(segue.destination)")
                return
            }
            addMealViewController.delegate = self
            
        default:
            os_log("Unexpected segue identifier: %@", log: OSLog.default, type: .error, "\(segue.identifier ?? "No segue available")")
            return
        }
    }
    
    @IBAction func unwindToToday(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddMealViewController, let meal = sourceViewController.meal {
            if let indexPath = tableView.indexPathForSelectedRow {
                mealController.todayMeals[indexPath.row] = meal
            } else {
                if let data = meal.mealImage, let image = UIImage(data: data) {
                    mealController.createToday(meal.mealName, meal.mealCalories, image)
                }
            }
            
            tableView?.reloadData()
        }
    }
    
    
}
