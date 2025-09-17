//
//  UserDTO.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//
import Foundation

struct UserDTO: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: AddressDTO?
    let phone: String?
    let website: String?
    let company: CompanyDTO?
}
