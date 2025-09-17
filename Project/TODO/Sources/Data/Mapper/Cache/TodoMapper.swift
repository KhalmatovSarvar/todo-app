//
//  TodoMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct TodoMapper: Mapper {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Todo) -> PTodoItem {
        let entity = PTodoItem(context: context)
        entity.id = Int64(input.id)
        entity.title = input.title
        entity.completed = input.completed
        entity.user = input.user.map { UserMapper(context: context).map($0) }
        return entity
    }
}
