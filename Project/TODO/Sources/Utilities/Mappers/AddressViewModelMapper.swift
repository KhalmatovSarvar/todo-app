//
//  AddressViewModelMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

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
