//
//  TodoListViewController.swift
//  TODO app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

final class TodoListViewController: BaseViewController {
    let viewModel: TodoListViewModel
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.round(radius: 12)
        searchBar.searchTextField.textColor = .contentPrimary
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .contentPrimary
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func configureView() {
        super.configureView()
        
        titleLabel.text = "FIrstPage"
        view.backgroundColor = .backgroundBody
        navigationItem.title = "TODO list"
        hideKeyboardOnTap(cancelsTouchesInView: true)
    }
    
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(searchBar)
        view.addSubview(titleLabel)
    }
    
    override func autoLayoutView() {
        super.autoLayoutView()
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
}

extension TodoListViewController: UISearchBarDelegate {
    
}
