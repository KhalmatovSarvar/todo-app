//
//  TodoListCoordinator.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

protocol TodoListCoordinator: BaseCoordinator {}

final class TodoListCoordinatorImpl: TodoListCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = TodoListViewModelImpl(coordinator: self)
        let vc = TodoListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
