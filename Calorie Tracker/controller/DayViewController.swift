//
//  TabViewController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/28/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit
import CoreData

class DayViewController: UIViewController {
    
    // MARK: Storyboard Outlets
    @IBOutlet var currentCalories: UILabel?
    @IBOutlet var goalCalories: UILabel?
    @IBOutlet var remainingCalories: UILabel?
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard container != nil else {
//            fatalError("This view needs a persistent controller.")
//        }
    }
    
}
