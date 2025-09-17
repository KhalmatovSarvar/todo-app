//
//  UserDTOMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct UserDTOMapper: Mapper {
    func map(_ input: UserDTO) -> User? {
        guard let id = input.id, let name = input.name else { return nil }
        let address = AddressDTOMapper().map(input.address)
        let company = CompanyDTOMapper().map(input.company)
        return User(
            id: id,
            name: name,
            username: input.username ?? "",
            email: input.email ?? "",
            address: address,
            phone: input.phone ?? "",
            website: input.website ?? "",
            company: company
        )
    }
}
