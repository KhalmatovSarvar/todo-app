//
//  TodoDTOMapper.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

struct TodoDTOMapper: Mapper {
    func map(_ input: TodoDTO) -> Todo {
        return Todo(
            userId: input.userId ?? 0,
            id: input.id ?? 0,
            title: input.title ?? "",
            completed: input.completed ?? false,
            user: nil
        )
    }
}

struct UserDTOMapper: Mapper {
    func map(_ input: UserDTO) -> User? {
        guard let id = input.id, let name = input.name else { return nil }
        let address = AddressDTOMapper().map(input.address)
        let company = CompanyDTOMapper().map(input.company)
        return User(
            id: id,
            name: name,
            username: input.username ?? "",
            email: input.email ?? "",
            address: address,
            phone: input.phone ?? "",
            website: input.website ?? "",
            company: company
        )
    }
}

struct AddressDTOMapper: Mapper {
    func map(_ input: AddressDTO?) -> Address? {
        guard let input else { return nil }
        let geo = GeoDTOMapper().map(input.geo)
        return Address(
            street: input.street ?? "",
            suite: input.suite ?? "",
            city: input.city ?? "",
            zipcode: input.zipcode ?? "",
            geo: geo
        )
    }
}

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

struct GeoDTOMapper: Mapper {
    func map(_ input: GeoDTO?) -> Geo? {
        guard let input else { return nil }
        return Geo(lat: input.lat ?? "", lng: input.lng ?? "")
    }
}
