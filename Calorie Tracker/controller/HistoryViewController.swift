//
//  HistoryViewController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class HistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    
    let mealController = MealController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealController.meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "historyViewCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HistoryViewCell else {
            fatalError("Dequeued cell is not an instance of HistoryViewCell")
        }
        
        let selectedMeal = mealController.meals[indexPath.row]
        
        guard let data = selectedMeal.mealImage, let image = UIImage(data: data) else {
            fatalError("The selected meal image was not found or null")
        }
        
        cell.image = image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "historyShowSegue":
            guard let historyDetailViewController = segue.destination as? HistoryDetailViewController else {
                os_log("Invalid segue destination: %@", log: OSLog.default, type: .error, "\(segue.destination)")
                return
            }
            
            guard let selectedCell = sender as? HistoryViewCell else {
                os_log("Unexpected sender: %@", log: OSLog.default, type: .error, "\(sender ?? "No sender available")")
                return
            }
            
            guard let indexPath = collectionView.indexPath(for: selectedCell) else {
                os_log("The selected cell is not being displayed by the collection view", log: OSLog.default, type: .error)
                return
            }
            
            let meal = mealController.meals[indexPath.row]
            historyDetailViewController.meal = meal
            
        default:
            os_log("Invalid segue identifier: %@", log: OSLog.default, type: .error, "\(segue.identifier ?? "No segue identifier available")")
        }
    }
    
    @IBAction func unwindToHistory(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealDetailViewController, let meal = sourceViewController.meal {
            if let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
                let selectedIndexPath = selectedIndexPaths.first?.row {
                mealController.updateHistoryMeal(mealController.meals[selectedIndexPath], meal)
            }
            
            collectionView.reloadData()
        }
    }
}
