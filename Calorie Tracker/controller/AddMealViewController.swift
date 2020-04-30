//
//  AddMealViewController.swift
//  Calorie Tracker
//
//  Created by Vincent Hoang on 4/30/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import Foundation
import UIKit
import os.log

class AddMealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var mealNameTextField: UITextField!
    @IBOutlet var caloriesTextField: UITextField!
    @IBOutlet var mealImageView: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal, let imageData = meal.image {
            navigationItem.title = meal.name
            mealNameTextField.text = meal.name
            caloriesTextField.text = String(meal.calories)
            mealImageView.image = imageData
        }
        
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let mealName = mealNameTextField.text ?? ""
        let mealCalories = Int(caloriesTextField.text ?? "")
        let mealImage = mealImageView.image?.pngData()
     
        meal = Meal()
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        mealNameTextField.resignFirstResponder()
        caloriesTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func updateSaveButtonState() {
        let text = mealNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
}
