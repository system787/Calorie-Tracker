//
//  MealMO.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/28/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MealMO: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var image: UIImage?
    @NSManaged var calories: Int
    
}
