//
//  CompanyMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

struct CompanyMapper: Mapper {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Company) -> PCompany {
        let entity = PCompany(context: context)
        entity.name = input.name
        entity.catchPhrase = input.catchPhrase
        entity.bs = input.bs
        return entity
    }
}
