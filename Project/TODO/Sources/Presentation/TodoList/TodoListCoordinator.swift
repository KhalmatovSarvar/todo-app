//
//  TodoListCoordinator.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

protocol TodoListCoordinator: BaseCoordinator {
    func showDetails(_ item: TodoItemViewModel)
}

final class TodoListCoordinatorImpl: TodoListCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkService = AppNetworkServiceFactory.default.makeNetworkService()
        let todoRepository = RemoteRepositoryImpl(networkService: networkService)
        let localRepository = LocalRepositoryImpl()
        let fetchUserListUseCase = FetchUserListUseCaseImpl(repository: todoRepository)
        let fetchTodoListUseCase = FetchTodoListUseCaseImpl(repository: todoRepository)
        let fetchTodosWithUsersUseCase = FetchTodosWithUsersUseCaseImpl(fetchTodos: fetchTodoListUseCase ,fetchUsers: fetchUserListUseCase, repository: localRepository)

        let vm = TodoListViewModelImpl(
            fetchTodosWithUsersUseCase: fetchTodosWithUsersUseCase,
            coordinator: self
        )
        let vc = TodoListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    func showDetails(_ item: TodoItemViewModel) {
        let coordinator = TodoDetailsCoordinatorImpl(item: item, navigationController: navigationController)
        coordinator.start()
    }
}
