//
//  TODOAppCoordinator.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

final class TODOAppCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = TodoListCoordinatorImpl(navigationController: navigationController)
        coordinator.start()
    }
}
