//
//  GeoViewModelMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct GeoViewModelMapper: Mapper {
    func map(_ input: Geo) -> GeoViewModel {
        return GeoViewModel(lat: input.lat, lng: input.lng
        )
    }
}
