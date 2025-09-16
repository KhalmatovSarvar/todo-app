//
//  TodoListTableViewCell.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        configureView()
        autoLayoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {}
    
    func configureView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func autoLayoutView() {}
    
    func setSelectedBackgroundColor(_ color: UIColor) {
        selectionStyle = .gray
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = color
    }
}
