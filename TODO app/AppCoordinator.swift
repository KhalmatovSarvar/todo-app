//
//  AppCoordinator.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import Foundation

public protocol AppCoordinator: BaseCoordinator {
    func appWillEnterForeground()
    func appDidEnterBackground()
}
