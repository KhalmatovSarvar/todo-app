//
//  CacheUserMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct PTodoMapper: Mapper {
    func map(_ input: PTodoItem) -> Todo {
        Todo(
            userId: Int(input.user?.id ?? 0),
            id: Int(input.id),
            title: input.title ?? "",
            completed: input.completed,
            user: input.user.map { PUserMapper().map($0) }
        )
    }
}
