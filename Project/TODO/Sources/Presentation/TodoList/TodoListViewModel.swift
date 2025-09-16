//
//  TodoListViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import Foundation

protocol TodoListViewModel {
    var items: [TodoItemViewModel] { get }
}

final class TodoListViewModelImpl: TodoListViewModel {
    let coordinator: TodoListCoordinator

    init(coordinator: TodoListCoordinator) {
        self.coordinator = coordinator
    }

    let items = [
        TodoItemViewModel(title: "TODO1", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO12", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO13", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO14", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO15", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO16", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO17", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO18", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO19", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO10", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO11", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO12", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO13", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO14", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO15", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO16", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO17", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO18", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO19", userName: "Sarvar"),
        TodoItemViewModel(title: "TODO10", userName: "Sarvar"),
    ]
}
