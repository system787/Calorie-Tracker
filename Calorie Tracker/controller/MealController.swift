//
//  MealController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/27/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit
import os.log

class MealController {
    
    var meals: [Meal] = [Meal]()
    var todayMeals: [Meal] = [Meal]()
    
    var mealURL: URL? {
        let fileManager = FileManager.default
        let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = documentDir?.appendingPathComponent("meals.plist")
        
        return url
    }
    
    var todayURL: URL? {
        let fileManager = FileManager.default
        let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = documentDir?.appendingPathComponent("today.plist")
        
        return url
    }
    
    init() {
        loadFromPersistentStore(url: mealURL)
        loadFromPersistentStore(url: todayURL)
    }
    
    func createToday(_ name: String, _ calories: Int, _ image: UIImage) {
        let meal = Meal(name, calories, image)
        todayMeals.append(meal)
        
        saveToPersistentStore(url: todayURL)
    }
    
    func createToday(_ meal: Meal) {
        if let data = meal.mealImage, let image = UIImage(data: data) {
            createToday(meal.mealName, meal.mealCalories, image)
        }
    }
    
    func deleteFromToday(_ meal: Meal) {
        if let index = todayMeals.firstIndex(of: meal) {
            todayMeals.remove(at: index)
        }
        saveToPersistentStore(url: todayURL)
    }
    
    func moveToHistory(_ meal: Meal) {
        deleteFromToday(meal)
        meals.append(meal)
        
        saveToPersistentStore(url: todayURL)
        saveToPersistentStore(url: mealURL)
    }
    
    func deleteFromHistory(_ meal: Meal) {
        if let index = meals.firstIndex(of: meal) {
            meals.remove(at: index)
        }
        saveToPersistentStore(url: mealURL)
    }
    
    func saveToPersistentStore(url: URL?) {
        os_log("saveToPersistentStore() called with url %@", log: OSLog.default, type: .debug, String(url?.absoluteString ?? "No url available"))
        
        let encoder = PropertyListEncoder()
        
        guard let unwrappedURL = url else {
            os_log("Unable to get URL to persistent store for writing", log: OSLog.default, type: .error)
            
            return
        }
        
        do {
            var encodedMeals: Data
            
            if unwrappedURL == mealURL {
                try encodedMeals = encoder.encode(meals)
            } else {
                try encodedMeals = encoder.encode(todayMeals)
            }
            
            try encodedMeals.write(to: unwrappedURL)
            
            os_log("Successfully encoded meals to persistent store", log: OSLog.default, type: .debug)
        } catch {
            os_log("Unsuccessful in encoding meals to write into persistent store", log: OSLog.default, type: .error)
            return
        }
        
        loadFromPersistentStore(url: unwrappedURL)
    }
    
    func loadFromPersistentStore(url: URL?) {
        os_log("loadFromPersistentStore() called with url %@", log: OSLog.default, type: .debug, String(url?.absoluteString ?? "No url available"))
        
        let decoder = PropertyListDecoder()
        
        guard let unwrappedURL = url else {
            os_log("Unable to get URL to persistent store for reading", log: OSLog.default, type: .error)
            
            return
        }
        
        do {
            var data: Data
            
            try data = Data.init(contentsOf: unwrappedURL)
            
            if unwrappedURL == mealURL {
                try meals = decoder.decode([Meal].self, from: data)
                os_log("Successfully decoded meals saved in meals persistent store", log: OSLog.default, type: .debug)

            } else {
                try todayMeals = decoder.decode([Meal].self, from: data)
                os_log("Successfully decoded meals saved in todayMeals persistent store", log: OSLog.default, type: .debug)
            }
            
            
        } catch {
            os_log("Unsuccessful in decoding meals saved in persistent store", log: OSLog.default, type: .error)
            
            return
        }
    }
}
