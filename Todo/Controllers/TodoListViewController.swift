//
//  ViewController.swift
//  Todo
//
//  Created by Oleg Ten on 26.06.2018.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {

    let realm = try! Realm()
    var todoItems : Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
             loadItems()
        }
    }
 
  
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
//MARK TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            // Ternary operator
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }

        
        return cell
    }
    
    //MARK TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            
            do{
            try realm.write {
                item.done = !item.done
                }
                
            }catch{
                print("Error")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete {
            print("Deleted")
            
            if let item = todoItems?[indexPath.row]{
                
                do{
                    try realm.write {
                        realm.delete(item)
                    }
                    
                }catch{
                    print("Error")
                }
            }
        //    tableView.reloadData()
           
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
   
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
       
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let currentCategory = self.selectedCategory{
               
                do{
                    try self.realm.write {
                        
                    let newItem = Item()
                        newItem.title = textField.text!
                    currentCategory.items.append(newItem)

                    }
                    
                }catch{
                    print("Error new Category")

            }
        }
                self.tableView.reloadData()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            textField = alertTextField

        }
        alert.addAction(action)
        present(alert, animated: true, completion:  nil)


        
    }
  
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        

        tableView.reloadData()

    }

}
extension TodoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}












