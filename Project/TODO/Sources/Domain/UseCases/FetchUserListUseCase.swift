//
//  FetchUserListUseCase.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//
import Foundation

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
