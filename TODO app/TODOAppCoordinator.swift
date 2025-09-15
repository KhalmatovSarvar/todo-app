//
//  TODOAppCoordinator.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

final class TODOAppCoordinator: AppCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = TodoListCoordinatorImpl(navigationController: navigationController)
        coordinator.start()
    }
    
    func appWillEnterForeground() {
        //handle the state that app enters foreground
    }
    
    func appDidEnterBackground() {
        //handle the state that app in background
    }
}
