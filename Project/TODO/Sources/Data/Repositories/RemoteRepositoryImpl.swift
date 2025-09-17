//
//  TodoRepositoryImpl.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

struct RemoteRepositoryImpl: RemoteRepository {
    private enum RemoteError: Error {
        case emptyResponse
    }

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchTodoList() async throws -> [Todo] {
        let requestModel = APIEndpoint.todos
        let request = try networkService.request(endpoint: requestModel)
        let response: [TodoDTO]? = try await request.serialize()

        guard let data = response else {
            throw RemoteError.emptyResponse
        }
        let mapper = TodoDTOMapper()
        return data.compactMap { mapper.map($0) }
    }
    
    func fetchUserList() async throws -> [User] {
        let requestModel = APIEndpoint.users
        let request = try networkService.request(endpoint: requestModel)
        let response: [UserDTO]? = try await request.serialize()

        guard let data = response else {
            throw RemoteError.emptyResponse
        }
        let mapper = UserDTOMapper()
        return data.compactMap { mapper.map($0) }
    }
}
