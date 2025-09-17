//
//  TodoDetailsViewController.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import UIKit

final class TodoDetailsViewController: BaseViewController {
    let viewModel: TodoDetailsViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TodoDetailsTableViewCell.self, forCellReuseIdentifier: TodoDetailsTableViewCell.reuseIdentifier)
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
        navigationItem.title = "Detials"
        hideKeyboardOnTap(cancelsTouchesInView: true)
    }

    init(viewModel: TodoDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        super.setupView()

        view.addSubview(tableView)
    }

    override func autoLayoutView() {
        super.autoLayoutView()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }
}

extension TodoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoDetailsTableViewCell.reuseIdentifier, for: indexPath) as! TodoDetailsTableViewCell
        let model = viewModel.sections[indexPath.section].rows[indexPath.row]
        cell.setup(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        header.title = viewModel.sections[section].title
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let title = viewModel.sections[section].title, !title.isEmpty {
            return 32
        } else {
            return 0
        }
    }
}

extension TodoDetailsViewController: UISearchBarDelegate {
}
