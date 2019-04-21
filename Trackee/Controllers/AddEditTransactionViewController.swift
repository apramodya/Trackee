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
    var selectedTransaction: Item!
    
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
        
        if let transactionToEdit = selectedTransaction {
            saveBtn.setTitle("Edit", for: .normal)
            
            // amount
            amountTxt.text = String(transactionToEdit.amount)
            
            // date
            datePicker.setDate(transactionToEdit.date, animated: false)
            selectedDate = transactionToEdit.date
            
            // type
            if transactionToEdit.type == "Expence" {
                typePicker.selectRow(1, inComponent: 0, animated: true)
                selectedType = transactionToEdit.type
            } else {
                typePicker.selectRow(0, inComponent: 0, animated: true)
                selectedType = transactionToEdit.type
            }
            
            // cateogry
            loadCategories()
            let cateIndex = categories.index(where: { $0.name == transactionToEdit.category })!
            selectedCategory = categories[cateIndex]
            categoryPicker.selectRow(cateIndex, inComponent: 0, animated: false)
            
            // note
            noteTxtArea.text = transactionToEdit.note
        }
        
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
    
    func saveTransaction(transaction: Item) {
        do {
            try realm.write {
                realm.add(transaction, update: false)
                print("Item added")
            }
        } catch {
            debugPrint("Error in saving item. >>>> \(error.localizedDescription)")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateTransaction(transaction: Item) {
        do {
            try realm.write {
                realm.add(transaction, update: true)
                print("Item updated")
            }
        } catch {
            debugPrint("Error in updating item. >>>> \(error.localizedDescription)")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BtnPressed(_ sender: Any) {
        selectedDate = datePicker.date
        note = noteTxtArea.text
        
        // validate amount
        guard let guardedAmount = amountTxt.text, guardedAmount.isNotEmpty, guardedAmount.isNumber else {
            simpleAlert(title: "Error", message: "Please enter an amount")
            return
        }
        amount = Double(guardedAmount)!
        
        if selectedTransaction == nil {
            // save
            let newTransaction = Item()
            newTransaction.type = selectedType
            newTransaction.date = selectedDate
            newTransaction.amount = amount
            newTransaction.note = note
            newTransaction.category = selectedCategory.name
            
            self.saveTransaction(transaction: newTransaction)
        } else {
            // edit
            let updatingTransaction = Item()
            updatingTransaction.itemID = selectedTransaction.itemID
            updatingTransaction.type = selectedType
            updatingTransaction.date = selectedDate
            updatingTransaction.amount = amount
            updatingTransaction.note = note
            updatingTransaction.category = selectedCategory.name
            
            self.updateTransaction(transaction: updatingTransaction)
        }
     
        selectedTransaction = nil
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
