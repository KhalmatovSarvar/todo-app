//
//  BaseCoordinator.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

public protocol BaseCoordinator {
    var navigationController: UINavigationController { get }
    func start()
}

public extension BaseCoordinator {
    func start() {}
}
