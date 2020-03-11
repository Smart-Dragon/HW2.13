//
//  TaskViewCell.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 11.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    weak var viewModel: TaskCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.name
        }
    }

}
