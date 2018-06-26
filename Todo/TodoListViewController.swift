//
//  ViewController.swift
//  Todo
//
//  Created by Oleg Ten on 26.06.2018.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Buy milk", "Change money","Test app"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
//MARK TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
 
        tableView.deselectRow(at: indexPath, animated: true)
    }
   


}

