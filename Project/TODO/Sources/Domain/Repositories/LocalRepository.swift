//
//  LocalRepository.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

protocol LocalRepository {
    func save(users: [User], todos: [Todo]) async throws
    func getTodosWithUsers(offset: Int, limit: Int, key: String?) async throws -> [Todo]
}
