//
//  LocalRepositoryImpl.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData

final class LocalRepositoryImpl: LocalRepository {
    func getTodosWithUsers() async throws -> [Todo] {
        let context = container.viewContext
        
        return try await context.perform {
            let request: NSFetchRequest<PTodoItem> = PTodoItem.fetchRequest()
            request.relationshipKeyPathsForPrefetching = ["user", "user.address", "user.company", "user.address.geo"]
            
            let todoEntities = try context.fetch(request)
            let todoMapper = PTodoMapper()
            return todoEntities.map { todoMapper.map($0) }
        }
    }


    private let container: PersistentContainer

    init(container: PersistentContainer = .shared) {
        self.container = container
    }

    func save(users: [User], todos: [Todo]) async throws {
        let context = container.newBackgroundContext()
        
        try await context.perform {
            let userIds = users.map { $0.id }
            let userFetch: NSFetchRequest<PUser> = PUser.fetchRequest()
            userFetch.predicate = NSPredicate(format: "id IN %@", userIds)
            let existingUsers = try context.fetch(userFetch)
            var userDict: [Int64: PUser] = Dictionary(uniqueKeysWithValues: existingUsers.map { ($0.id, $0) })

            for user in users {
                let userEntity = userDict[Int64(user.id)] ?? UserMapper(context: context).map(user)
                userDict[Int64(user.id)] = userEntity
            }

            let todoIds = todos.map { $0.id }
            let todoFetch: NSFetchRequest<PTodoItem> = PTodoItem.fetchRequest()
            todoFetch.predicate = NSPredicate(format: "id IN %@", todoIds)
            let existingTodos = try context.fetch(todoFetch)
            var todoDict: [Int64: PTodoItem] = Dictionary(uniqueKeysWithValues: existingTodos.map { ($0.id, $0) })

            let todoMapper = TodoMapper(context: context)
            for todo in todos {
                let todoEntity = todoDict[Int64(todo.id)] ?? todoMapper.map(todo)
                todoEntity.user = userDict[Int64(todo.userId)]
                todoDict[Int64(todo.id)] = todoEntity
            }

            if context.hasChanges {
                try context.save()
            }

            print("Saved Users: \(try context.count(for: PUser.fetchRequest())), Saved Todos: \(try context.count(for: PTodoItem.fetchRequest()))")
        }
    }


//    func getTodosWithUsers() async throws -> [Todo] {
//        let context = container.viewContext
//
//        return try await context.perform {
//            let request: NSFetchRequest<PTodoItem> = PTodoItem.fetchRequest()
//            request.relationshipKeyPathsForPrefetching = ["user"]
//
//            let todoEntities = try context.fetch(request)
//            let mapper = TodoMapper()
//            return todoEntities.map { mapper.map($0) }
//        }
//    }
}
