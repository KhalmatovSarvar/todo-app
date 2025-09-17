//
//  GeoDTOMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct GeoDTOMapper: Mapper {
    func map(_ input: GeoDTO?) -> Geo? {
        guard let input else { return nil }
        return Geo(lat: input.lat ?? "", lng: input.lng ?? "")
    }
}
