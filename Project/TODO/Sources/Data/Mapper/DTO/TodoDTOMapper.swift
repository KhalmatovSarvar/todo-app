//
//  TodoDTOMapper.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//
import Foundation

struct TodoDTOMapper: Mapper {
    func map(_ input: TodoDTO) -> Todo {
        return Todo(
            userId: input.userId ?? 0,
            id: input.id ?? 0,
            title: input.title ?? "",
            completed: input.completed ?? false,
            user: nil
        )
    }
}
