//
//  TaskController.swift
//  Task
//
//  Created by Lee McCormick on 1/13/21.
//

import Foundation

class TaskController {
    
    // MARK: - Properties
    static var shared = TaskController()
    
    var tasks: [Task] = []
    
    // MARK: - CRUD Methods
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let task = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(task)
        saveToPersistenceStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task){
       // task.isComplete = !task.isComplete
        task.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        saveToPersistenceStore()
        
    }
    
    // MARK: - Save and Load From Persistance Store
    // file URL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Task.json")
        return fileURL
    }
    
    // save
    func saveToPersistenceStore() {
        do {
            // need to add Encodable on Song class
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL())
        } catch { //automatic catch error
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // load
    
    func loadFromPersistanceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

