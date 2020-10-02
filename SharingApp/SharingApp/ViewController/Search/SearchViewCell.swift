//
//  TableViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/07.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
    static let identifier = "SearchViewCell"
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(itemImageView)
        addSubview(itemLabel)
    }
    
    override func layoutSubviews() {
        itemImageView.frame = CGRect(x: 5,
                                     y: 5,
                                     width: height - 10,
                                     height: height - 10)
        itemLabel.frame = CGRect(x: itemImageView.right + 10,
                                 y: 5,
                                 width: width - (itemImageView.width - 15),
                                 height: height - 10)
    }
    
    public func didSearch(image: UIImage, text: String) {
        itemImageView.image = image
        itemLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
