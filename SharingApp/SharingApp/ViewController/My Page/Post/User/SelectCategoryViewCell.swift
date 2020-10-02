//
//  SelectCategoryViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/13.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol SelectCategoryViewCellDelegate: AnyObject {
    func didTapRemoveButton(indexpath: IndexPath)
}

class SelectCategoryViewCell: UITableViewCell {
    
    static let identifier = "SelectCategoryViewCell"
    
    weak var delegate: SelectCategoryViewCellDelegate?
    
    private var indexPath: IndexPath?
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(categoryLabel)
        addSubview(removeButton)
        removeButton.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryLabel.frame = CGRect(x: 10,
                                     y: 0,
                                     width: contentView.width - 50,
                                     height: contentView.height)
        removeButton.frame = CGRect(x: contentView.width - 50,
                                    y: 0, width: 50,
                                    height: contentView.height)
    }
    
    public func configure(data: String, indexPath: IndexPath) {
        categoryLabel.text = data
        self.indexPath = indexPath
    }
    
    @objc private func didTapRemoveButton() {
        guard let indexPath = self.indexPath else { return }
        delegate?.didTapRemoveButton(indexpath: indexPath)
    }
}
