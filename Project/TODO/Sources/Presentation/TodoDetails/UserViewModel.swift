//
//  TodoViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import Foundation

struct UserViewModel {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressViewModel
    let phone: String
    let website: String
    let company: CompanyViewModel
}

struct AddressViewModel {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoViewModel
}

struct GeoViewModel {
    let lat: String
    let lng: String
}

struct CompanyViewModel {
    let name: String
    let catchPhrase: String
    let bs: String
}
