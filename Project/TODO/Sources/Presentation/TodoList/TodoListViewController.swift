//
//  TodoListViewController.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import Combine
import UIKit

final class TodoListViewController: BaseViewController {
    private let viewModel: TodoListViewModel
    private let keyboardManager = KeyboardManager()
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        return tableView
    }()

    private let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        keyboardManager.startObservingKeyboard()

        keyboardManager.keyboardWillShowObserver = { [weak self] height, timeInterval in
            self?.keyboardWillShowObserver(height: height, timeInterval: timeInterval)
        }
        keyboardManager.keyboardWillHideObserver = { [weak self] in
            self?.keyboardWillHideObserver()
        }
    }

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
        view.addSubview(loader)
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

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func setupObserver() {
        super.setupObserver()

        viewModel.items
            .removeDuplicates()
            .combineLatest(viewModel.isLoading)
            .sink(receiveValue: { [weak self] _, isLoading in
                guard let self else { return }
                manageLoader(isLoading)
                tableView.isUserInteractionEnabled = !isLoading
                tableView.reloadData()
            })
            .store(in: &cancellables)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardManager.stopObservingKeyboard()
    }

    private func manageLoader(_ isLoading: Bool) {
        if isLoading {
            loader.startAnimating()
        } else {
            loader.stopAnimating()
        }
    }

    private func keyboardWillShowObserver(height: CGFloat, timeInterval: TimeInterval) {
        tableView.contentInset.bottom = height

        UIView.animate(withDuration: timeInterval) {
            self.view.layoutIfNeeded()
        }
    }

    private func keyboardWillHideObserver() {
        tableView.contentInset.bottom = 0

        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
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

extension TodoListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map({ $0.row }).max() else { return }
        let threshold = 8
        if maxRow >= viewModel.items.value.count - threshold {
            viewModel.fetchNextPage()
        }
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        viewModel.search(with: "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
