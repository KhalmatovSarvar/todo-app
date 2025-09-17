//
//  UserViewModelMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//
import Foundation

struct UserViewModelMapper: Mapper {
    func map(_ input: User) -> UserViewModel {
        let address = input.address.map { AddressViewModelMapper().map($0) }
        let company = input.company.map { CompanyViewModelMapper().map($0) }

        return UserViewModel(
            id: input.id,
            name: input.name,
            username: input.username,
            email: input.email,
            address: address,
            phone: input.phone,
            website: input.website,
            company: company
        )
    }
}
