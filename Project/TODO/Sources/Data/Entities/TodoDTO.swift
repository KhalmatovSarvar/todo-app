//
//  FavoriteCardDTO.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import Foundation

struct TodoDTO: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
