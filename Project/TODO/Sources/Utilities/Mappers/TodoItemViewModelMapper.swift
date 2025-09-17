//
//  TodoItemViewModelMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct TodoItemViewModelMapper: Mapper {
    func map(_ input: Todo) -> TodoItemViewModel? {
        guard let user = input.user.map(UserViewModelMapper().map) else { return nil }
        return TodoItemViewModel(
            userId: input.userId,
            id: input.id,
            title: input.title,
            isCompleted: input.completed,
            user: user
        )
    }
}
