//
//  AddressDTO.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct AddressDTO: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: GeoDTO?
}
