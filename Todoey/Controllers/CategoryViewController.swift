//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kunwar Luthera on 11/13/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("no of rows is \(categoryArray.count)")
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt Called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
        
    }
    //MARK - Data Manipulation Methods
    
    func saveCategory() {
         do {
            try context.save()
        } catch  {
            print("Error saving the context for Category, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        // instead of arguments can use as below
        //let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        }catch {
            
            print("Error fetching data from Category context, \(error)")
        }
        tableView.reloadData()

    }
    //MARK - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextFieldData = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default){(action) in
            let newCategory = Category(context: self.context)
            newCategory.name = alertTextFieldData.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
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
            
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
