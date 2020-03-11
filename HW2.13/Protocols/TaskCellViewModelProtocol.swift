//
//  TaskCellViewModelProtocol.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 11.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

protocol TaskCellViewModelProtocol: class {
    
    var task: Task { get }
    var name: String { get }
    
}
