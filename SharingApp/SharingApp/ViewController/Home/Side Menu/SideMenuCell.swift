//
//  SideMenuCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/04.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    static let identifier = "SideMenuCell"
    
    public let cancelButton: CustomButton = {
       let button = CustomButton()
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    public let categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cancelButton)
        contentView.addSubview(categoryLabel)
    }
    
    override func layoutSubviews() {
        cancelButton.frame = CGRect(x: contentView.width - 30,
                                    y: 5,
                                    width: 20,
                                    height: contentView.height - 10)
        categoryLabel.frame = CGRect(x: 5,
                                     y: 5,
                                     width: width,
                                     height: contentView.height - 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomButton: UIButton {
    public var indexPath: IndexPath?
}
