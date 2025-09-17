//
//  LocalRepositoryImpl.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData

final class LocalRepositoryImpl: LocalRepository {
    private let container: PersistentContainer

    init(container: PersistentContainer = .shared) {
        self.container = container
    }

    func getTodosWithUsers(offset: Int, limit: Int, key: String?) async throws -> [Todo] {
        let context = container.viewContext

        return try await context.perform {
            let request: NSFetchRequest<PTodoItem> = PTodoItem.fetchRequest()

            request.relationshipKeyPathsForPrefetching = [
                "user",
                "user.address",
                "user.address.geo",
                "user.company",
            ]

            if let key = key, !key.isEmpty {
                let predicate = NSPredicate(
                    format: "title CONTAINS[cd] %@ OR user.name CONTAINS[cd] %@",
                    key, key
                )
                request.predicate = predicate
            }

            request.fetchOffset = offset
            request.fetchLimit = limit

            request.sortDescriptors = [NSSortDescriptor(keyPath: \PTodoItem.id, ascending: true)]

            let todoEntities = try context.fetch(request)
            return todoEntities.map { PTodoMapper().map($0) }
        }
    }

    func save(users: [User], todos: [Todo]) async throws {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy

        try await context.perform {
            var userDict: [Int64: PUser] = [:]
            let userMapper = UserMapper(context: context)

            for user in users {
                let fetch: NSFetchRequest<PUser> = PUser.fetchRequest()
                fetch.predicate = NSPredicate(format: "id == %d", user.id)
                fetch.fetchLimit = 1

                if let existingUser = try context.fetch(fetch).first {
                    userDict[Int64(user.id)] = existingUser
                } else {
                    let newUser = userMapper.map(user)
                    userDict[Int64(user.id)] = newUser
                }
            }

            if context.hasChanges {
                try context.save()
            }

            let todoMapper = TodoMapper(context: context)

            for todo in todos {
                let fetch: NSFetchRequest<PTodoItem> = PTodoItem.fetchRequest()
                fetch.predicate = NSPredicate(format: "id == %d", todo.id)
                fetch.fetchLimit = 1

                if let _ = try context.fetch(fetch).first {
                    continue
                } else {
                    let newTodo = todoMapper.map(todo)
                    if let userEntity = userDict[Int64(todo.userId)] {
                        newTodo.user = userEntity
                    }
                }
            }

            let inserted = context.insertedObjects.count
            let updated = context.updatedObjects.count
            let total = users.count + todos.count
            let ignored = total - inserted - updated

            print("Inserted: \(inserted), Updated: \(updated), Ignored: \(ignored)")

            if context.hasChanges {
                try context.save()
            }

            let userCount = try context.count(for: PUser.fetchRequest())
            let todoCount = try context.count(for: PTodoItem.fetchRequest())
            print("users: \(userCount), todos: \(todoCount)")
        }
    }
}
