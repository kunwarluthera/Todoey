//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kunwar Luthera on 11/13/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt Called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories have been added yet"
        

        return cell
        
    }
    //MARK - Data Manipulation Methods
    
    func saveCategory(category: Category) {
         do {
            try realm.write {
                realm.add(category)
            }
        } catch  {
            print("Error saving the context for Category, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories () {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()

    }
    //MARK - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextFieldData = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default){(action) in
            let newCategory = Category()
            newCategory.name = alertTextFieldData.text!
            self.saveCategory(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            alertTextFieldData = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItem", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}
