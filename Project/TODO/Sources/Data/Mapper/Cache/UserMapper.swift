//
//  UserMapper.swift
//  TODO app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct UserMapper: Mapper {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: User) -> PUser {
        let entity = PUser(context: context)
        entity.id = Int64(input.id)
        entity.name = input.name
        entity.username = input.username
        entity.email = input.email
        entity.phone = input.phone
        entity.website = input.website
        entity.address = input.address.map { AddressMapper(context: context).map($0) }
        entity.company = input.company.map { CompanyMapper(context: context).map($0) }
        return entity
    }
}
