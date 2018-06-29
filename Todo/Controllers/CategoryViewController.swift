//
//  CategoryViewController.swift
//  Todo
//
//  Created by Oleg Ten on 6/29/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categoryArray : Results<Category>!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCategory", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "toItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
        
        vc.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("Deleted")
            
            if let category = categoryArray?[indexPath.row]{
                
                do{
                    try realm.write {
                        realm.delete(category)
                    }
                    
                }catch{
                    print("Error")
                }
            }
            //    tableView.reloadData()
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func buttonAddCategory(_ sender: UIBarButtonItem) {
     
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            self.saveCategory(category: newCategory)
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new Category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion:  nil)
        
        
        
    }
    
    func saveCategory(category: Category) {
       
        do{
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print("error saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory() {
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
}
