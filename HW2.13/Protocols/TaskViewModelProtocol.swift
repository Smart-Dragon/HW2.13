//
//  TaskViewModelProtocol.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 11.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

protocol TaskViewModelProtocol {
    
    var tasks: [Task] { get set }
    func getNumberOfRows() -> Int
    func getCellViewModel(for indexPath: IndexPath) -> TaskCellViewModelProtocol
}
