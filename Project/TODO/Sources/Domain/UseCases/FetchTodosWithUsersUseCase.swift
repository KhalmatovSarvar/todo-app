//
//  FetchTodoAndUserListUseCase.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

protocol FetchTodosWithUsersUseCase {
    func execute() async throws
}

struct FetchTodosWithUsersUseCaseImpl: FetchTodosWithUsersUseCase {
    private let fetchTodos: FetchTodoListUseCase
    private let fetchUsers: FetchUserListUseCase
    private let repository: LocalRepository

    init(
        fetchTodos: FetchTodoListUseCase,
        fetchUsers: FetchUserListUseCase,
        repository: LocalRepository
    ) {
        self.fetchTodos = fetchTodos
        self.fetchUsers = fetchUsers
        self.repository = repository
    }

    func execute() async throws {
        async let todos = fetchTodos.execute()
        async let users = fetchUsers.execute()
        let (fetchedTodos, fetchedUsers) = try await (todos, users)

        try await repository.save(users: fetchedUsers, todos: fetchedTodos)
    }
}
