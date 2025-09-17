//
//  CompanyViewModelMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import Foundation

struct CompanyViewModelMapper: Mapper {
    func map(_ input: Company) -> CompanyViewModel {
        return CompanyViewModel(
            name: input.name,
            catchPhrase: input.catchPhrase,
            bs: input.bs
        )
    }
}
