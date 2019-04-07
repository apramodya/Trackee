//
//  AddEditCategoryViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class AddEditCategoryViewController: UIViewController{
    
    // IBOutlets
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    // variables
    var selectedType = types[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        typePicker.delegate = self
        typePicker.dataSource = self
        
        // dismiss keyboard
        self.hideKeyboard()
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveCategory(_ sender: Any) {
        guard let category = categoryName.text, category.isNotEmpty else {
            simpleAlert(title: "Error", message: "Category name is missing", toFocus: categoryName)
            return
        }
        
        print(category)
        print(selectedType)
    }
    
}

extension AddEditCategoryViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row]
    }
}
