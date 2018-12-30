//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Martin Blondin on 2018-12-15.
//  Copyright © 2018 Le Studio de Technologie Éducative. All rights reserved.
//

import UIKit

import RealmSwift


class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    
    
    
    
    
    
    //MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    //    let category = categoryArray[indexPath.row]
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
 
    
    //MARK: Data manipulation
    
    func save(category: Category){
        
        do {
            
            try realm.write{
                realm.add(category)
                }
        } catch{
            print("error saving context \(error)")
        }
      tableView.reloadData()
        
    }
  
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
   }
    
    //MARK: Add New Categories
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default){
            (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            self.save(category: newCategory)
            
            }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new category"
            textField = alertTextField
            print(alertTextField.text!)
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
        //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationsVC = segue.destination as! ToDoListViewController
    
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationsVC.selectedCategory = categories?[indexPath.row] 
        }
    }
}
