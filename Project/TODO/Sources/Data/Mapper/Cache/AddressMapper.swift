//
//  AddressMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//
import CoreData
import Foundation

struct AddressMapper: Mapper {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Address) -> PAddress {
        let entity = PAddress(context: context)
        entity.street = input.street
        entity.suite = input.suite
        entity.city = input.city
        entity.zipcode = input.zipcode
        entity.geo = input.geo.map { GeoMapper(context: context).map($0) }
        return entity
    }
}
