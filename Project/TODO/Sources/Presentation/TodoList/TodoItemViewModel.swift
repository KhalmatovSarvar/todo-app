//
//  TodoViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import Foundation

struct TodoItemViewModel {
    let userId: Int
    let id: Int
    let title: String
    let isCompleted: Bool
    let user: UserViewModel
}
