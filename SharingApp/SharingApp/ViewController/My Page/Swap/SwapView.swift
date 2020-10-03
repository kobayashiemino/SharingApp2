//
//  SwapView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/10/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import Koloda

class SwapView: KolodaView {
    
    public var itemImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let blandLabel: UILabel = {
        let label = UILabel()
        label.text = "bland"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(itemImageView)
        addSubview(blandLabel)
        addSubview(titleLabel)
        addSubview(likeButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        itemImageView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        blandLabel.frame = CGRect(x: 10, y: itemImageView.bottom + 10, width: width - 20, height: 40)
        titleLabel.frame = CGRect(x: 10, y: blandLabel.bottom + 10, width: width - 20, height: 40)
        likeButton.frame = CGRect(x: width - 62, y: itemImageView.bottom - 62, width: 52, height: 52)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
