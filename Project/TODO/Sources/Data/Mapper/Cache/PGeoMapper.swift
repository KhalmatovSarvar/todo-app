//
//  PGeoMapper.swift
//  TODO app
//
//  Created by Sarvar on 17/09/25.
//


import CoreData
import Foundation

struct PGeoMapper: Mapper {
    func map(_ input: PGeo) -> Geo {
        Geo(lat: input.lat ?? "", lng: input.lng ?? "")
    }
}