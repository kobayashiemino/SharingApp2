//
//  MyPageCollectionViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SDWebImage

class MyPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyPageCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        addSubview(productLabel)
        addSubview(brandLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        productLabel.frame = CGRect(x: 0, y: photoImageView.bottom + 5, width: width, height: 20)
        brandLabel.frame = CGRect(x: 0, y: productLabel.bottom + 5, width: width, height: 20)
    }
    
    public func configure(post: Post) {
        let imageURL = URL(string: post.imageURL)
        photoImageView.sd_setImage(with: imageURL, completed: nil)
        
        productLabel.text = post.title
        brandLabel.text = post.title
    }
}
