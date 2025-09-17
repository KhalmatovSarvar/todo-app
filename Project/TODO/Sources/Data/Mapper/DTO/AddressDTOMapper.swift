//
//  AddressDTOMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation
struct AddressDTOMapper: Mapper {
    func map(_ input: AddressDTO?) -> Address? {
        guard let input else { return nil }
        let geo = GeoDTOMapper().map(input.geo)
        return Address(
            street: input.street ?? "",
            suite: input.suite ?? "",
            city: input.city ?? "",
            zipcode: input.zipcode ?? "",
            geo: geo
        )
    }
}
