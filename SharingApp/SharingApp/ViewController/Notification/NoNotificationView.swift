//
//  NoNotificationView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/09.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class NoNotificationView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "no_notification"
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell")
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(iconImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.frame = CGRect(x: (width - 50) / 2, y: 0, width: 50, height: 50)
        titleLabel.frame = CGRect(x: 0, y: iconImage.bottom, width: width, height: height - 50)
    }
}
