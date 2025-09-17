//
//  FetchTodoListUseCase.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//
protocol FetchTodoListUseCase {
    func execute() async throws -> [Todo]
}

struct FetchTodoListUseCaseImpl: FetchTodoListUseCase {
    private let repository: RemoteRepository

    init(repository: RemoteRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Todo] {
        return try await repository.fetchTodoList()
    }
}

protocol FetchUserListUseCase {
    func execute() async throws -> [User]
}

struct FetchUserListUseCaseImpl: FetchUserListUseCase {
    private let repository: RemoteRepository

    init(repository: RemoteRepository) {
        self.repository = repository
    }

    func execute() async throws -> [User] {
        return try await repository.fetchUserList()
    }
}
