//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Lee McCormick on 1/13/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // taskDueDatePicker.delegate = self
        updateView()
    }
    
    // MARK: - Actions
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        //   let taskNote = taskNotesTextView.text, !taskNote.isEmpty,
        // let date = date else { return }
        
        //if task is nil >> create new task
        
        if let task = task {
            TaskController.shared.update(task: task, name: taskName, notes: taskNotesTextView.text, dueDate: date)
            
        } else {
            // not nit >> have value >> update
            
            TaskController.shared.createTaskWith(name: taskName, notes: taskNotesTextView.text, dueDate: date)
        }
        
        
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
        
    }
    
    // MARK: - Helper Fuctions
    func updateView() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    
}
