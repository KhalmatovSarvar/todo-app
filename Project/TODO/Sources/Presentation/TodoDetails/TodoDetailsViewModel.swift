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
    let item: TodoItemViewModel

    init(item: TodoItemViewModel, coordinator: TodoDetailsCoordinator) {
        self.coordinator = coordinator
        self.item = item
    }

    var sections: [SectionItem] {
        var result: [SectionItem] = []

        let title = item.title
        let completed: Bool = item.isCompleted

        result.append(SectionItem(
            title: nil,
            rows: [("Title", title), ("Completed", completed ? "Yes" : "No")])
        )

        let user = item.user
        result.append(SectionItem(
            title: "User Info",
            rows: [
                ("Name", user.name),
                ("Username", user.username),
                ("Email", user.email),
            ])
        )

        if let address = user.address {
            var rows: [(label: String, value: String)] = [
                ("Street", address.street),
                ("Suite", address.suite),
                ("City", address.city),
                ("Zipcode", address.zipcode),
            ]

            if let geo = address.geo {
                rows.append(("Geo", "\(geo.lat), \(geo.lng)"))
            }

            result.append(
                SectionItem(title: "Address", rows: rows)
            )
        }

        result.append(SectionItem(
            title: "Contact",
            rows: [
                ("Phone", user.phone),
                ("Website", user.website)])
        )

        if let company = user.company {
            result.append(SectionItem(
                title: "Company",
                rows: [
                    ("Name", company.name),
                    ("CatchPhrase", company.catchPhrase),
                    ("BS", company.bs)])
            )
        }
        return result
    }
}
