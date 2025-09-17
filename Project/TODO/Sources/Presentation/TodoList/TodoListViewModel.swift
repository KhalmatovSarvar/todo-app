//
//  TodoListViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import Combine
import Foundation

protocol TodoListViewModel {
    var items: CurrentValueSubject<[TodoItemViewModel], Never> { get }

    func selectItem(_ item: TodoItemViewModel)
}

final class TodoListViewModelImpl: TodoListViewModel {
    var items = CurrentValueSubject<[TodoItemViewModel], Never>([])

    private let coordinator: TodoListCoordinator
    private let fetchTodosWithUsersUseCase: FetchTodosWithUsersUseCase

    init(
        fetchTodosWithUsersUseCase: FetchTodosWithUsersUseCase,
        coordinator: TodoListCoordinator
    ) {
        self.coordinator = coordinator
        self.fetchTodosWithUsersUseCase = fetchTodosWithUsersUseCase

        fetchTodosWithUserList()
    }

    func fetchTodosWithUserList() {
        Task { @MainActor in
            do {
                let models = try await fetchTodosWithUsersUseCase.execute()
                let viewModels = models.compactMap { TodoItemViewModelMapper().map($0) }
                items.send(viewModels)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func selectItem(_ item: TodoItemViewModel) {
        coordinator.showDetails(item)
    }
}
