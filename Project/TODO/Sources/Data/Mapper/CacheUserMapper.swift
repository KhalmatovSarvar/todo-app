//
//  CacheUserMapper.swift
//  TODO: app
//
//  Created by Sarvar on 17/09/25.
//

import CoreData
import Foundation

public struct UserMapper: Mapper {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: User) -> PUser {
        let entity = PUser(context: context)
        entity.id = Int64(input.id)
        entity.name = input.name
        entity.username = input.username
        entity.email = input.email
        entity.phone = input.phone
        entity.website = input.website
        entity.address = input.address.map { AddressMapper(context: context).map($0) }
        entity.company = input.company.map { CompanyMapper(context: context).map($0) }
        return entity
    }
}

public struct AddressMapper: Mapper {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Address) -> PAddress {
        let entity = PAddress(context: context)
        entity.street = input.street
        entity.suite = input.suite
        entity.city = input.city
        entity.zipcode = input.zipcode
        entity.geo = input.geo.map { GeoMapper(context: context).map($0) }
        return entity
    }
}

public struct GeoMapper: Mapper {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Geo) -> PGeo {
        let entity = PGeo(context: context)
        entity.lat = input.lat
        entity.lng = input.lng
        return entity
    }
}

public struct CompanyMapper: Mapper {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Company) -> PCompany {
        let entity = PCompany(context: context)
        entity.name = input.name
        entity.catchPhrase = input.catchPhrase
        entity.bs = input.bs
        return entity
    }
}

public struct TodoMapper: Mapper {
    private let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) { self.context = context }

    func map(_ input: Todo) -> PTodoItem {
        let entity = PTodoItem(context: context)
        entity.id = Int64(input.id)
        entity.title = input.title
        entity.completed = input.completed
        entity.user = input.user.map { UserMapper(context: context).map($0) }
        return entity
    }
}

public struct PUserMapper: Mapper {
    func map(_ input: PUser) -> User {
        User(
            id: Int(input.id),
            name: input.name ?? "",
            username: input.username ?? "",
            email: input.email ?? "",
            address: input.address.map { PAddressMapper().map($0) },
            phone: input.phone ?? "",
            website: input.website ?? "",
            company: input.company.map { PCompanyMapper().map($0) }
        )
    }
}

public struct PAddressMapper: Mapper {
    func map(_ input: PAddress) -> Address {
        Address(
            street: input.street ?? "",
            suite: input.suite ?? "",
            city: input.city ?? "",
            zipcode: input.zipcode ?? "",
            geo: input.geo.map { PGeoMapper().map($0) }
        )
    }
}

public struct PGeoMapper: Mapper {
    func map(_ input: PGeo) -> Geo {
        Geo(lat: input.lat ?? "", lng: input.lng ?? "")
    }
}

public struct PCompanyMapper: Mapper {
    func map(_ input: PCompany) -> Company {
        Company(
            name: input.name ?? "",
            catchPhrase: input.catchPhrase ?? "",
            bs: input.bs ?? ""
        )
    }
}

public struct PTodoMapper: Mapper {
    func map(_ input: PTodoItem) -> Todo {
        Todo(
            userId: Int(input.user?.id ?? 0),
            id: Int(input.id),
            title: input.title ?? "",
            completed: input.completed,
            user: input.user.map { PUserMapper().map($0) }
        )
    }
}
