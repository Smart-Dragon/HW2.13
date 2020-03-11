//
//  TaskViewController.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 10.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: TaskViewModelProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadTasks()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.task.rawValue, for: indexPath) as! TaskViewCell
        cell.viewModel = viewModel.getCellViewModel(for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.tasks[indexPath.row]
        let editAction = UIContextualAction(style: .normal, title: "Изменить") {
            (contextualAction, view, boolValue) in
            self.editTask(task: task)
        }
        // ! - осознанный: если ошибся в написание пусть упадет, сразу поправлю
        editAction.backgroundColor = UIColor(named: "EditButton")!
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {
            (contextualAction, view, boolValue) in
            self.deleteTask(task: task)
        }
        // ! - осознанный: если ошибся в написание пусть упадет, сразу поправлю
        deleteAction.backgroundColor = UIColor(named: "DeleteButton")!
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = viewModel.tasks[sourceIndexPath.row]
        viewModel.tasks.remove(at: sourceIndexPath.row)
        viewModel.tasks.insert(task, at: destinationIndexPath.row)
        DataManager.shared.saveOrderTask(viewModel: viewModel)

    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none;
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editTask(task: viewModel.tasks[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Private Methods
    
    private func setupUI() {
        title = "Задачи"
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: CellConstants.task.rawValue)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let barAppear = UINavigationBarAppearance()
            barAppear.configureWithOpaqueBackground()
            barAppear.backgroundColor = UIColor(gray: 50, alpha: 0.7)
            barAppear.titleTextAttributes = [.foregroundColor: UIColor.yellow]
            barAppear.largeTitleTextAttributes = [.foregroundColor: UIColor.yellow]
            
            let navbar = navigationController?.navigationBar
            navbar?.standardAppearance = barAppear
            navbar?.scrollEdgeAppearance = barAppear
            navbar?.tintColor = .yellow
            
            let addButton = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addTask)
            
            )
            
            let sortButton = UIBarButtonItem(
                title: "1-3-2",
                style: .plain,
                target: self,
                action: #selector(setEditMode)
            )
            
            navigationItem.leftBarButtonItem = sortButton
            navigationItem.rightBarButtonItem = addButton
        }
    }
    
    private func showEditAlert(title: String, message: String, task: Task? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField()
        if let task = task {
            alert.textFields?.first?.text = task.name
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) {_ in
            guard let taskName = alert.textFields?.first?.text, !taskName.isEmpty else { return }
            if let task = task {
                DataManager.shared.updateTask(task: task, name: taskName, completion: self.updateRow)
            } else {
                DataManager.shared.addTask(name: taskName, completion: self.insertRow)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
    @objc private func setEditMode() {
        tableView.isEditing = !tableView.isEditing
    }
    
    @objc private func addTask() {
        showEditAlert(title: "Новая задача", message: "Что вы хотите сделать?")
    }
    
    private func editTask(task: Task) {
        showEditAlert(title: "Редактирование", message: "Задача: " + (task.name ?? "undefined"), task: task)
    }
    
    private func deleteTask(task: Task) {
        DataManager.shared.deleteTask(task: task, completion: self.removeRow)
    }
    
    private func loadTasks() {
        viewModel = TaskViewModel(tasks: DataManager.shared.fetchAllTasks())
    }
    
    private func insertRow(task: Task) {
        viewModel.tasks.append(task)
        let index = IndexPath(row: viewModel.tasks.count - 1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
    }
    
    private func removeRow(task: Task) {
        if let row = viewModel.tasks.firstIndex(of: task) {
            viewModel.tasks.remove(at: row)
            let index = IndexPath(row: row, section: 0)
            tableView.deleteRows(at: [index], with: .automatic)
        }
    }
    
    private func updateRow(task: Task) {
        if let row = viewModel.tasks.firstIndex(of: task) {
            viewModel.tasks[row] = task
            let index = IndexPath(row: row, section: 0)
            tableView.reloadRows(at: [index], with: .automatic)
        }
    }

}

