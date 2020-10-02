//
//  MenuButtunCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MenuButtunCell: UICollectionViewCell {
    
    static let identifier = "MenuButtunCell"
    
    public let menuButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .systemGray
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 0.5
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(menuButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuButton.frame = bounds
        menuButton.layer.cornerRadius = menuButton.width / 2
    }
}
