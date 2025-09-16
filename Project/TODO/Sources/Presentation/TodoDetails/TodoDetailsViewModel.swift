//
//  TodoListViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import Foundation

protocol TodoDetailsViewModel {
    var sections: [SectionItem] { get }
}

final class TodoDetailsViewModelImpl: TodoDetailsViewModel {
    let coordinator: TodoDetailsCoordinator
    let model: UserViewModel

    init(user: UserViewModel, coordinator: TodoDetailsCoordinator) {
        self.coordinator = coordinator
        model = user
    }
    
    var sections: [SectionItem] {
            [
                SectionItem(title: "User Info", rows: [
                    ("Name", model.name),
                    ("Username", model.username),
                    ("Email", model.email)
                ]),
                SectionItem(title: "Address", rows: [
                    ("Street", model.address.street),
                    ("Suite", model.address.suite),
                    ("City", model.address.city),
                    ("Zipcode", model.address.zipcode),
                    ("Geo", "\(model.address.geo.lat), \(model.address.geo.lng)")
                ]),
                SectionItem(title: "Contact", rows: [
                    ("Phone", model.phone),
                    ("Website", model.website)
                ]),
                SectionItem(title: "Company", rows: [
                    ("Name", model.company.name),
                    ("CatchPhrase", model.company.catchPhrase),
                    ("BS", model.company.bs)
                ])
            ]
        }
}


