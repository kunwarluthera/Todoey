//
//  ViewController.swift
//  Todoey
//
//  Created by Kunwar Luthera on 10/23/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    let realm = try! Realm()
    var todoItems: Results<Item>?
    var selectedCategory: Category? {
        didSet {
           loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Item()
//        newItem.title = "Buy Milk"
//        todoItems.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy Fruits"
//        todoItems.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Buy House"
//        todoItems.append(newItem3)
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//
//            todoItems = items
//        }
        //loadItems()
    }

    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt Called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]
        {
            print("INSIDE IF OF ITEMS")
            cell.textLabel?.text = item.title
            
            //Ternary operator ==>
            // value = condition ? valueifTrue : valueIfFalse
            cell.accessoryType = item.done == true ? .checkmark : .none
            // above ternary operator replaces below 4 lines
            
            //        if item.done == true {
            //            cell.accessoryType = .checkmark
            //        }else {
            //            cell.accessoryType = .none
            //        }
        }else {
            print("INSIDE ELSE OF NO ITEMS")
            cell.textLabel?.text = "No Items have been added yet"
        }
        
        return cell
        
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    //This deletes the items from the realm -> realm.delete(item)
                    item.done = !item.done
                }
            }catch {
                print("Error saving the done status,  \(error)")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextFieldData = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            // what will happen when user clicks add button
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = alertTextFieldData.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch {
                    
                    print("Error writing the data to realm \(error)")
                }
                
            }
            
            self.tableView.reloadData()
            


        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            alertTextFieldData = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK - Model Manipulation Methods
    

    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()

    }

}
//MARK - Search Bar method
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
//            print("SEARCH CLICKED ")
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        print("SEARCH BAR TEXT is",searchBar.text!,"This")
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request,predicate: predicate)

    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }
}


