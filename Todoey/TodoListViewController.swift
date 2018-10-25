//
//  ViewController.swift
//  Todoey
//
//  Created by Kunwar Luthera on 10/23/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Buy Fruits", "Buy Vegetables", "Buy Milk"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            print("The Row selected is \(indexPath.row) and the value is \(itemArray[indexPath.row])")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextFieldData = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            // what will happen when user clicks add button
            self.itemArray.append(alertTextFieldData.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            alertTextFieldData = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}


