//
//  BaseNaviagtionController.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

class BaseNavigationController: UINavigationController {
    var appearance: UINavigationBarAppearance {
        let backButtonImage = UIImage(named: "arrow.left.24")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.contentPrimary,
            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        return appearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationBar.tintColor = .contentPrimary
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
