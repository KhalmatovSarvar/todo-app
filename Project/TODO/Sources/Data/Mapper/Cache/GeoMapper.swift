//
//  GeoMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct GeoMapper: Mapper {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Geo) -> PGeo {
        let entity = PGeo(context: context)
        entity.lat = input.lat
        entity.lng = input.lng
        return entity
    }
}
