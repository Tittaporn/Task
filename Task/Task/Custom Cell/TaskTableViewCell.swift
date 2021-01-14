//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Lee McCormick on 1/13/21.
//

import UIKit
// MARK: - Protocol
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateView()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?

    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
    // MARK: - Helper Fuctions
    func updateView() {
        
        guard let task = task else {return}
        taskNameLabel.text = task.name
        
        if task.isComplete {
            let completeImage = UIImage(named: "complete")
            completionButton.setBackgroundImage(completeImage, for: .normal)
        } else {
            let incompleteImage = UIImage(named: "incomplete")
            completionButton.setBackgroundImage(incompleteImage, for: .normal)
        }
        
    }
}

/*
 // MARK: - Property Observers: didSet
 https://www.hackingwithswift.com/read/8/5/property-observers-didset
 
 Swift’s solution is property observers, which let you execute code whenever a property has changed. To make them work, we use either didSet to execute code when a property has just been set, or willSet to execute code before a property has been set.


 */
