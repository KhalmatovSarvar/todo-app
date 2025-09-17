//
//  TodoListTableViewCell.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import UIKit

final class TodoListTableViewCell: BaseTableViewCell {
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .contentPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .contentSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .contentSecondary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func setupView() {
        super.setupView()

        addSubview(contentStack)
        addSubview(separatorView)

        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
    }

    override func configureView() {
        super.configureView()
    }

    override func autoLayoutView() {
        super.autoLayoutView()

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            contentStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentStack.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8),
            contentStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension TodoListTableViewCell {
    func setup(with model: TodoItemViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.user.name
    }
}
