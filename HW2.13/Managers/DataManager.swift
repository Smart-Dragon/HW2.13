//
//  DataManager.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 10.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    // MARK: - Public Properties
    
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "taskDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext = { persistentContainer.viewContext }()

    // MARK: - Init
    
    private init() {}

    // MARK: - Public Methods
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addTask(name: String, completion: @escaping (Task) -> ()) {
        let task = NSEntityDescription.insertNewObject(
            forEntityName: "Task",
            into: viewContext) as! Task
        task.name = name
        saveTask(task: task, completion: completion)
    }
    
    func updateTask(task: Task, name: String, completion: @escaping (Task) -> ()) {
        task.name = name
        saveTask(task: task, completion: completion)
    }
    
    func deleteTask(task: Task, completion: @escaping (Task) -> ()) {
        viewContext.delete(task)
        saveTask(task: task, completion: completion)
    }
    
    func saveTask(task: Task, completion: @escaping (Task) -> ()) {
        saveContext()
        completion(task)
    }
    
    func fetchAllTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
