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
    var itemArray: [[String : String]] = []
    var defaults: UserDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let defaultItemArray = defaults.array(forKey: "ToDoListItem") as? [[String : String]] {
            itemArray = defaultItemArray
        }
    }
    
    //MARKS: Tableview datasource methods
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
    
    //MARKS: Tableview delegate methods
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
    
    //MARKS: Barbutton methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}

