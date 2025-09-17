//
//  FetchTodosWithUsersLocalUseCase.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

protocol GetTodosWithUsersUseCase {
    func execute(offset: Int, limit: Int, key: String?) async throws -> [Todo]
}

struct GetTodosWithUsersUseCaseImpl: GetTodosWithUsersUseCase {
    private let repository: LocalRepository

    init(repository: LocalRepository) {
        self.repository = repository
    }

    func execute(offset: Int, limit: Int, key: String?) async throws -> [Todo] {
        try await repository.getTodosWithUsers(offset: offset, limit: limit, key: key)
    }
}
