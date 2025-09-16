//
//  TodoDetailsCoordinator.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

protocol TodoDetailsCoordinator: BaseCoordinator {}

final class TodoDetailsCoordinatorImpl: TodoDetailsCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let user = UserViewModel(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: AddressViewModel(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: GeoViewModel(lat: "-37.3159", lng: "81.1496")
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: CompanyViewModel(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "harness real-time e-markets"
            )
        )

        let vm = TodoDetailsViewModelImpl(user: user, coordinator: self)
        let vc = TodoDetailsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
