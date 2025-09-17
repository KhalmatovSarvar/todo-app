//
//  PCompanyMapper.swift
//  TODO app
//
//  Created by Sarvar on 17/09/25.
//


import CoreData
import Foundation

struct PCompanyMapper: Mapper {
    func map(_ input: PCompany) -> Company {
        Company(
            name: input.name ?? "",
            catchPhrase: input.catchPhrase ?? "",
            bs: input.bs ?? ""
        )
    }
}
