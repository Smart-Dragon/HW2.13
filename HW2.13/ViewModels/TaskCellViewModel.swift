//
//  TaskCellViewModel.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 11.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import Foundation

class TaskCellViewModel: TaskCellViewModelProtocol {
    
    // MARK: - Public Properties
    
    var task: Task
    var name: String {
        return task.name ?? "undefined"
    }
    
    // MARK: - Init
    
    init(task: Task) {
        self.task = task
    }
    
}
