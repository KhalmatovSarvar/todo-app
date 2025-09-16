//
//  TodoListViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import Foundation

protocol TodoListViewModel {
    
}

final class TodoListViewModelImpl: TodoListViewModel {
    let coordinator: TodoListCoordinator
    
    init(coordinator: TodoListCoordinator) {
        self.coordinator = coordinator
    }
    
}
