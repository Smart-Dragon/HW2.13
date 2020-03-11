//
//  TaskViewModel.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 11.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import Foundation

class TaskViewModel: TaskViewModelProtocol {
    
    // MARK: - Public Properties
    
    var tasks: [Task]
    
    // MARK: - Init
    
    init(tasks: [Task]) {
        self.tasks = tasks
    }
    
    // MARK: - Public Methods
    func getNumberOfRows() -> Int {
        tasks.count
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> TaskCellViewModelProtocol {
        return TaskCellViewModel(task: tasks[indexPath.row])
    }

}
