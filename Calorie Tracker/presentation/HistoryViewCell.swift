//
//  HistoryViewCell.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage? {
        didSet{
            updateView()
        }
    }
    
    private func updateView() {
        if let image = image {
            imageView.image = image
        }
    }
}
