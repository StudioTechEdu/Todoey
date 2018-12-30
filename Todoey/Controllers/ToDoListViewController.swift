//
//  ViewController.swift
//  Todoey
//
//  Created by Martin Blondin on 2018-11-24.
//  Copyright © 2018 Le Studio de Technologie Éducative. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var toDoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
           loadItems()
        }
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
)
        
   loadItems()
        
        
        
    }
    // MARK: - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
       if let item = toDoItems?[indexPath.row]{
        
            cell.textLabel?.text = item.title
        
            cell.accessoryType = item.done ? .checkmark : .none
    
        
       }else {
        cell.textLabel?.text = "No Items added"
        }
      
        return cell
    }
    
    //MARK: Table View delegate methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
           
            do{
            try realm.write {
           
                  item.done = !item.done
            }
        }
        catch{
            print("error saving new item \(error)")
        }
        }
        
        tableView.reloadData()
 

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: add new items
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user pressed the add item button
            
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreation = Date()
                    currentCategory.items.append(newItem)
                    }
                } catch {
                        print("error writing new item\(error)")
                    }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
            print(alertTextField.text!)
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
//    func saveItems(){
//
//        do {
//
//           try context.save()
//        } catch{
//            print("error saving context \(error)")
//        }
//        self.tableView.reloadData()
//
//    }
//
    func loadItems() {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreation", ascending: true)
        

        tableView.reloadData()
    }
 }
    
//MARK: Search bar methods

extension ToDoListViewController: UISearchBarDelegate {

func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreation", ascending: true)

    tableView.reloadData()

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
}

