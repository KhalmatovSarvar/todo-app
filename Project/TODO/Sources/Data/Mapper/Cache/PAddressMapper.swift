//
//  PAddressMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct PAddressMapper: Mapper {
    func map(_ input: PAddress) -> Address {
        Address(
            street: input.street ?? "",
            suite: input.suite ?? "",
            city: input.city ?? "",
            zipcode: input.zipcode ?? "",
            geo: input.geo.map { PGeoMapper().map($0) }
        )
    }
}
