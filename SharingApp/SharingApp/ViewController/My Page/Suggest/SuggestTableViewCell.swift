//
//  SuggestTableViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/27.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    
    static let identifier = "SuggestTableViewCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let detail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let suggestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "tray"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .lightGray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(title)
        addSubview(detail)
        addSubview(suggestButton)
        
        suggestButton.addTarget(self, action: #selector(didTapSuggestedButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = CGRect(x: 5, y: 0, width: width - 60, height: height / 2)
        detail.frame = CGRect(x: 5, y: title.bottom, width: width - 60, height: height / 2)
        suggestButton.frame = CGRect(x: width - 55, y: 5, width: 50, height: 50)
        suggestButton.layer.cornerRadius = suggestButton.width / 2
    }
    
    public func configure(suggest: Suggest) {
        title.text = suggest.title
        detail.text = suggest.detail
    }
    
    @objc private func didTapSuggestedButton() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
