//
//  TodoDetailsCoordinator.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

protocol TodoDetailsCoordinator: BaseCoordinator {}

final class TodoDetailsCoordinatorImpl: TodoDetailsCoordinator {
    let item: TodoItemViewModel
    var navigationController: UINavigationController

    init( item: TodoItemViewModel, navigationController: UINavigationController) {
        self.item = item
        self.navigationController = navigationController
    }

    func start() {
        let vm = TodoDetailsViewModelImpl(item: item, coordinator: self)
        let vc = TodoDetailsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
