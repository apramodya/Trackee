//
//  CategoryViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // variables
    var realm = try! Realm()
    var categories: Results<Category>!
    var categoryToPass: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadCategories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        categoryToPass = nil
    }

    func loadCategories() {
        categories = realm.objects(Category.self).sorted(byKeyPath: "type", ascending: true)
    }
    
    func deleteCategory(category: Category) {
        do {
            try realm.write {
                realm.delete(category)
            }
        } catch {
            debugPrint("Error in deleting category. >>>> \(error.localizedDescription)")
            return
        }
    }
}

    // MARK: - Tableview methods
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CategoryTableViewCell {
            cell.configureCell(category: categories[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryToPass = categories[indexPath.row]
        performSegue(withIdentifier: "toEditCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddEditCategoryViewController {
            destinationVC.selectedCategory = categoryToPass
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let categoryToDelete = categories[indexPath.row]
        deleteCategory(category: categoryToDelete)
        tableView.reloadData()
    }
}
