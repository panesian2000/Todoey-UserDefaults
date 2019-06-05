//
//  ViewController.swift
//  Todoey-UserDefaults
//
//  Created by Kenny Loh on 4/6/19.
//  Copyright © 2019 ProApp Concept Pte Ltd. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    /*
        Note:   UserDefaults are used to store small data and standard data type.
                Custom class object are not allow. Data are store in plist.
    */
    
    //MARK: Local global variables
    let defaults: UserDefaults = UserDefaults()
    var itemArray: [[String : String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve todo item list from defaults
        if let defaultItemArray = defaults.array(forKey: "ToDoListItem") as? [[String : String]] {
            itemArray = defaultItemArray
        }
        
        configSettingTableView()
    }
    
    //MARK: Tableview config setting methods
    func configSettingTableView() {
        tableView.rowHeight = 50
    }
    
    //MARK: Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item: [String : String] = itemArray[indexPath.row]
        
        // Ternary Conditional Operator - question ? answer1 : answer2.
        cell.textLabel?.text = item["Description"]
        cell.accessoryType = item["Completed"] == "Y" ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        
        return cell
    }
    
    //MARK: Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        var item: [String : String] = itemArray[indexPath.row]
        
        // Ternary Conditional Operator - question ? answer1 : answer2.
        item["Completed"] = item["Completed"] == "Y" ? "N" : "Y"
        cell.accessoryType = item["Completed"] == "Y" ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        
        itemArray[indexPath.row] = item
        defaults.set(itemArray, forKey: "ToDoListItem")
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //MARK: Barbutton methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var itemTextField: UITextField = UITextField()
        let alert: UIAlertController = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: UIAlertController.Style.alert)
        let alertAddAction: UIAlertAction = UIAlertAction(title: "Add Item", style: UIAlertAction.Style.default) {
            (action) in
            
            if let description = itemTextField.text {
                if !description.isEmpty {
                    let item: [String : String] = ["Description" : description, "Completed" : "N"]
                    
                    self.itemArray.append(item)
                    self.defaults.set(self.itemArray, forKey: "ToDoListItem")
                    
                    self.tableView.reloadData()
                }
            }
        }
        let alertCancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            (action) in
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            itemTextField = textField
        }
        alert.addAction(alertAddAction)
        alert.addAction(alertCancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

