//
//  Meal.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/27/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    // MARK: Properties
    var name: String
    var image: UIImage?
    var calories: Int
    
    // MARK: Archiving Paths
    static let DOCUMENT_DIR = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ARCHIVE_URL = DOCUMENT_DIR.appendingPathComponent("localMeals")
    
    // MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let image = "image"
        static let calories = "calories"
    }
    
    // MARK: Initialization
    init?(_ name: String, _ image: UIImage?, _ calories: Int) {
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
        self.image = image
        self.calories = calories
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(calories, forKey: PropertyKey.calories)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        let calories = aDecoder.decodeInteger(forKey: PropertyKey.calories)
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name, image, calories)
    }
}
