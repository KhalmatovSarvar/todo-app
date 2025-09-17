//
//  CompanyDTOMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct CompanyDTOMapper: Mapper {
    func map(_ input: CompanyDTO?) -> Company? {
        guard let input else { return nil }
        return Company(
            name: input.name ?? "",
            catchPhrase: input.catchPhrase ?? "",
            bs: input.bs ?? ""
        )
    }
}
