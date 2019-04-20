//
//  AddEditTransactionViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import RealmSwift

class AddEditTransactionViewController: UIViewController, UINavigationControllerDelegate {

    // IBOutlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var noteTxtArea: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var typePicker: UIPickerView!
    
    // variables
    var realm = try! Realm()
    var categories: Results<Category>!
    var selectedType: String = types[0] // income
    var selectedDate: Date = Date()
    var amount: Double = 0.0
    var selectedCategory: Category!
    var note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Button
        saveBtn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        loadCategories()
        
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        // dismiss keyboard
        self.hideKeyboard()
    }

    func loadCategories() {
        if selectedType == types[1] {
            categories = realm.objects(Category.self).filter("type BEGINSWITH  'E'").sorted(byKeyPath: "name")
        } else {
            categories = realm.objects(Category.self).filter("type BEGINSWITH  'I'").sorted(byKeyPath: "name")
        }
        selectedCategory = categories[0]
    }
    
    func getDataToSave() {
        selectedDate = datePicker.date
        note = noteTxtArea.text
        
        // validate amount
        guard let guardedAmount = amountTxt.text, guardedAmount.isNotEmpty, guardedAmount.isNumber else {
            simpleAlert(title: "Error", message: "Please enter an amount")
            return
        }
        amount = Double(guardedAmount)!
    }
    
    func saveTransaction(transaction: Item) {
        do {
            try realm.write {
                realm.add(transaction)
                print("Item added")
            }
        } catch {
            debugPrint("Error in saving item. >>>> \(error.localizedDescription)")
            return
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func BtnPressed(_ sender: Any) {
        getDataToSave()
        
        // save
        let newTransaction = Item()
        newTransaction.type = selectedType
        newTransaction.date = selectedDate
        newTransaction.amount = amount
        newTransaction.note = note
        newTransaction.category = selectedCategory.name
        
        self.saveTransaction(transaction: newTransaction)
    }
    
}

extension AddEditTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Category picker view methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return categories.count
        } else if pickerView == typePicker {
            return types.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            return categories[row].name
        } else if pickerView == typePicker {
            return types[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker {
            selectedCategory = categories[row]
        } else if pickerView == typePicker {
            selectedType = types[row]
            loadCategories()
            categoryPicker.reloadAllComponents()
        }
        
    }
    
}
