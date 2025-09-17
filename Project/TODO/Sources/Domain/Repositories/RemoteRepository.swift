//
//  TodoRepository.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

protocol RemoteRepository {
    func fetchTodoList() async throws -> [Todo]
    func fetchUserList() async throws -> [User]
}
