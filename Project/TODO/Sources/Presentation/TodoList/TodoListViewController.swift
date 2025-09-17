//
//  TodoListViewController.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit
import Combine

final class TodoListViewController: BaseViewController {
    let viewModel: TodoListViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.round(radius: 12)
        searchBar.placeholder = "Search"
        searchBar.searchTextField.textColor = .contentPrimary
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func configureView() {
        super.configureView()

        view.backgroundColor = .backgroundBody
        navigationItem.title = "TODO list"
        hideKeyboardOnTap(cancelsTouchesInView: false)
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
        view.addSubview(tableView)
    }

    override func autoLayoutView() {
        super.autoLayoutView()

        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }

    override func setupObserver() {
        super.setupObserver()

        viewModel.items
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }
                tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    var items: [TodoItemViewModel] {
        viewModel.items.value
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as! TodoListTableViewCell
        let model = items[indexPath.row]
        cell.setup(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = items[indexPath.row]
        viewModel.selectItem(item)
    }
}

extension TodoListViewController: UISearchBarDelegate {
}
