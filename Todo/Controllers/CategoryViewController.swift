//
//  CategoryViewController.swift
//  Todo
//
//  Created by Oleg Ten on 6/29/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCategory", for: indexPath)
        
        let item = categoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "toItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
        
        vc.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    

    @IBAction func buttonAddCategory(_ sender: UIBarButtonItem) {
     
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new Category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion:  nil)
        
        
        
    }
    
    func saveCategory() {
       
        do{
            try context.save()
            
        }catch{
            print("error saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching data\(error)")
        }
        tableView.reloadData()
        
    }
    
}
