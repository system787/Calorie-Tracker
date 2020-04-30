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

protocol AddMealViewControllerDelegate {
    func mealWasAdded(_ meal: Meal)
}

class AddMealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet var mealNameTextField: UITextField!
    @IBOutlet var caloriesTextField: UITextField!
    @IBOutlet var mealImageView: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    var delegate: AddMealViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal, let imageData = meal.mealImage {
            navigationItem.title = meal.mealName
            mealNameTextField.text = meal.mealName
            caloriesTextField.text = String(meal.mealCalories)
            mealImageView.image = UIImage(data: imageData)
        }
        
        mealNameTextField.delegate = self
        
        updateSaveButtonState()
    }
    
    // MARK: - Storyboard Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        guard let mealImage = mealImageView.image else {
            os_log("No image was selected", log: OSLog.default, type: .error)
            
            let alert = UIAlertController(title: "Error", message: "No image was selected.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            
            return
        }
        
        let mealName = mealNameTextField.text ?? ""
        let mealCalories = Int(caloriesTextField.text ?? "") ?? 0
     
        meal = Meal(mealName, mealCalories, mealImage)
    }
    
    // MARK: - ImagePickerController
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        mealNameTextField.resignFirstResponder()
        caloriesTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            os_log("Expected a dictionary containing an image, but was provided the following: %@", log: OSLog.default, type: .error, "\(info)")

            return
        }
    
        mealImageView.image = selectedImage
    
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    // MARK: - Utility
    
    private func updateSaveButtonState() {
        let text = mealNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
}
