//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Lee McCormick on 1/13/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.loadFromPersistanceStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell()}

        
        let task = TaskController.shared.tasks[indexPath.row]
        // Configure the cell...
        
        cell.delegate = self
        cell.task = task
        //cell.updateView()
        //cell.textLabel?.text = task.name

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          
            // find task to delete with Index
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            
            // using delete fuction to delete it
            TaskController.shared.delete(task: taskToDelete)
            

            // Delete the row from the data source

            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }


 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController
                  else { return }
            let task = TaskController.shared.tasks[indexPath.row]
            destination.task = task
        }
    }
   

}

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else {return}
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateView()
    }
    
    
}
