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

struct AddressViewModelMapper: Mapper {
    func map(_ input: Address) -> AddressViewModel {
        let geo = input.geo.map { GeoViewModelMapper().map($0) }
        return AddressViewModel(
            street: input.street,
            suite: input.suite,
            city: input.city,
            zipcode: input.zipcode,
            geo: geo
        )
    }
}

struct CompanyViewModelMapper: Mapper {
    func map(_ input: Company) -> CompanyViewModel {
        return CompanyViewModel(
            name: input.name,
            catchPhrase: input.catchPhrase,
            bs: input.bs
        )
    }
}

struct GeoViewModelMapper: Mapper {
    func map(_ input: Geo) -> GeoViewModel {
        return GeoViewModel(lat: input.lat, lng: input.lng
        )
    }
}
