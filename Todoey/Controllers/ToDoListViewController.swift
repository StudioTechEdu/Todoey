//
//  ViewController.swift
//  Todoey
//
//  Created by Martin Blondin on 2018-11-24.
//  Copyright © 2018 Le Studio de Technologie Éducative. All rights reserved.
//

import UIKit


class ToDoListViewController: UITableViewController {

  var itemArray = [Item]()
    
  let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Buy Eggos"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy bread"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy pop-corn"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Buy beers"
        itemArray.append(newItem4)
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
        
    }
// MARK - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK Table View delegate methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK add new items
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user pressed the add item button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
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
    
    
}

