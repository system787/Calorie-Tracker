//
//  LogMO.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/29/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class LogMO: NSManagedObject {
    @NSManaged var meal: Meal?
    @NSManaged var date: Date
}
