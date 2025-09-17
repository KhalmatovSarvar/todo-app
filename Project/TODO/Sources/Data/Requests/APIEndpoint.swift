//
//  TodoRequest.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

enum APIEndpoint: Requestable {
    case todos
    case users

    var path: String {
        switch self {
        case .todos:
            return "todos"
        case .users:
            return "users"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .todos, .users:
            return .get
        }
    }
}
