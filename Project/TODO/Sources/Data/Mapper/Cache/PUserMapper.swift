//
//  PUserMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct PUserMapper: Mapper {
    func map(_ input: PUser) -> User {
        User(
            id: Int(input.id),
            name: input.name ?? "",
            username: input.username ?? "",
            email: input.email ?? "",
            address: input.address.map { PAddressMapper().map($0) },
            phone: input.phone ?? "",
            website: input.website ?? "",
            company: input.company.map { PCompanyMapper().map($0) }
        )
    }
}
