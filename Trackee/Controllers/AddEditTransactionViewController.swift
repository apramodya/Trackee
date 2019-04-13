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
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var noteTxtArea: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    // variables
    var realm = try! Realm()
    var categories: Results<Category>!
    var selectedType: String = types[1] // expence
    var selectedDate: Date = Date()
    var amount: Double = 0.0
    var selectedCategory: Category!
    var note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCategories()
        selectedCategory = categories[0]
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        // dismiss keyboard
        self.hideKeyboard()
    }

    func loadCategories() {
        categories = realm.objects(Category.self).filter("type BEGINSWITH  'E'").sorted(byKeyPath: "name")
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
        print("Selected date \(selectedDate)")
        print("Selected amount \(amount)")
        print("Selected category \(selectedCategory.name)")
        print("Note \(note)")
        
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
}
