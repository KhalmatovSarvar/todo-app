//
//  TodoListTableViewCell.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import UIKit

final class TodoDetailsTableViewCell: BaseTableViewCell {
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .contentSecondary
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .contentPrimary
        label.textAlignment = .right
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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
            contentStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contentStack.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8),
            contentStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),

            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension TodoDetailsTableViewCell {
    func setup(with model: (String, String)) {
        titleLabel.text = model.0
        descriptionLabel.text = model.1
    }
}
