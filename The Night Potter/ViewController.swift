//
//  ViewController.swift
//  The Night Potter
//
//  Created by Sahil Bhosale on 22/02/18.
//  Copyright © 2018 Sahil Bhosale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    // Created task arrays
    var dailyTasks = [ Task(name: "Check all windows",type: .daily, completed: false, lastCompleted: nil),
                       Task(name: "Check all doors",type: .daily, completed: true, lastCompleted: nil),
                       Task(name: "Check the mailbox",type: .daily, completed: false, lastCompleted: nil),
                       Task(name: "Empty Trash containers",type: .daily, completed: false, lastCompleted: nil),
                       Task(name: "If freezing, check water pipes",type: .daily, completed: false, lastCompleted: nil),
                       Task(name: "Document strange situations",type: .daily, completed: false, lastCompleted: nil) ]
    
    var weeklyTasks = [Task(name: "Check inside all cabins", type: .weekly, completed: false, lastCompleted: nil),
                       Task(name: "Flush all things the washroom",type: .weekly, completed: false, lastCompleted: nil),
                       Task(name: "Walk the perimeter of property",type: .weekly, completed: false, lastCompleted: nil)]
    
    var monthlyTasks = [Task(name: "Test the security", type: .monthly, completed: false, lastCompleted: nil),
                        Task(name: "Test motion detector", type: .monthly, completed: false, lastCompleted: nil),
                        Task(name: "Test smoke alarms", type: .monthly, completed: false, lastCompleted: nil)]
    
    //Delegate methods
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "completed"){ (action:UIContextualAction, sourceView: UIView, actionPerformed:(Bool) -> Void) in
            
            //find the right object and set it to completed
            switch indexPath.section{
                case 0:
                self.dailyTasks[indexPath.row].completed = true
                case 1:
                self.weeklyTasks[indexPath.row].completed = true
                case 2:
                self.monthlyTasks[indexPath.row].completed = true
            default:
                break
            }
            tableView.reloadData()
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    
    // Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section{
            case 0:
                return dailyTasks.count
            case 1:
                return weeklyTasks.count
            case 2:
                return monthlyTasks.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var currentTask: Task!
        
        switch indexPath.section {
        case 0:
            currentTask = dailyTasks[indexPath.row]
        case 1:
            currentTask = weeklyTasks[indexPath.row]
        case 2:
            currentTask = monthlyTasks[indexPath.row]
        default:
            break
        }
        cell.textLabel!.text = currentTask.name
        
        if currentTask.completed{
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        }
        else{
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Monthly Tasks"
        default:
            return nil
        }
    }
    
    
    

    @IBAction func toggleDarkMode(_ sender: Any) {
        let mySwitch = sender as! UISwitch
        
        if mySwitch.isOn{
            
            view.backgroundColor = UIColor.darkGray
        }
        else{
            view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        
        let confirm = UIAlertController(title: "Are you sure?", message: "Really rest the list?",preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive){
            action in
            
            for i in 0..<self.dailyTasks.count{
                self.dailyTasks[i].completed = false
            }
            for i in 0..<self.weeklyTasks.count{
                self.weeklyTasks[i].completed = false
            }
            for i in 0..<self.monthlyTasks.count{
                self.monthlyTasks[i].completed = false
            }
            self.taskTableView.reloadData()
        }
    
    let noAction = UIAlertAction(title:"No", style: .cancel){
        action in
        print("That was a close one!")
    }
    confirm.addAction(yesAction)
    confirm.addAction(noAction)
    
    present(confirm, animated: true, completion: nil)
}

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

