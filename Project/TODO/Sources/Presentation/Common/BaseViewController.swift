//
//  ViewController.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

class BaseViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        initialRequests()
        setupView()
        configureView()
        autoLayoutView()
        setupObserver()
    }
    
    func initialRequests() {}
    
    func setupView() {}
    
    func configureView() {}
    
    func autoLayoutView() {}
    
    func setupObserver() {}
}

extension BaseViewController {
    final func hideKeyboardOnTap(cancelsTouchesInView: Bool = false, delegate: UIGestureRecognizerDelegate? = nil) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = cancelsTouchesInView
        tapGesture.delegate = delegate
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

private extension BaseViewController {
    func configureNavigationItem() {
        navigationItem.backButtonTitle = ""
    }
}
