//
//  AddEditCategoryViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import RealmSwift

class AddEditCategoryViewController: UIViewController, UINavigationControllerDelegate {
    
    // IBOutlets
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    // variables
    let realm = try! Realm()
    var selectedType = types[0]
    var categories: Results<Category>?
    var selectedCategory: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Button
        saveBtn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        typePicker.delegate = self
        typePicker.dataSource = self
        
        // load data if edit category
        if let categoryToEdit = selectedCategory {
            saveBtn.setTitle("Edit", for: .normal)
            categoryName.text = categoryToEdit.name
            
            if categoryToEdit.type == "Expence" {
                typePicker.selectRow(1, inComponent: 0, animated: true)
                selectedType = categoryToEdit.type
            } else {
                typePicker.selectRow(0, inComponent: 0, animated: true)
                selectedType = categoryToEdit.type
            }
            
        }
        
        // dismiss keyboard
        self.hideKeyboard()
    }
    
    @IBAction func saveCategory(_ sender: Any) {
        guard let category = categoryName.text, category.isNotEmpty else {
            simpleAlert(title: "Error", message: "Category name is missing", toFocus: categoryName)
            return
        }
        
        // add new
        if selectedCategory == nil {
            let newCategory = Category()
            newCategory.name = category.capitalized
            newCategory.type = selectedType
            
            self.saveCategory(cateogry: newCategory)
        } else {
            // edit
            let updatingCategory = Category()
            updatingCategory.categoryID = selectedCategory.categoryID
            updatingCategory.name = category.capitalized
            updatingCategory.type = selectedType
            
            self.updateCategory(cateogry: updatingCategory)
        }
        
        selectedCategory = nil
    }
    
    // save category
    func saveCategory(cateogry: Category) {
        do {
            try realm.write {
                realm.add(cateogry, update: false)
            }
        } catch {
            debugPrint("Error in saving category. >>>> \(error.localizedDescription)")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // update category
    func updateCategory(cateogry: Category) {
        do {
            try realm.write {
                realm.add(cateogry, update: true)
            }
        } catch {
            debugPrint("Error in updating category. >>>> \(error.localizedDescription)")
            return
        }
        
        navigationController?.popViewController(animated: true)
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
