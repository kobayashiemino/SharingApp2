//
//  SideMenuTableViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/04.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {
    
    static let identifier = "SideMenuTableViewCell"
    
    private var categoryTitle: String?
    
    public let itemView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "記事"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .lightGray
        label.layer.shadowColor = UIColor.lightGray.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
//    private let blurView: UIVisualEffectView = {
//        let blur = UIBlurEffect(style: .dark)
//        let view = UIVisualEffectView(effect: blur)
//        view.alpha = 0.5
//        return view
//    }()
//
//    private let thankButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "rosette"), for: .normal)
//        button.tintColor = .systemGray
//        button.backgroundColor = .white
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.systemGray.cgColor
//        return button
//    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let brandNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(itemView)
        itemView.addSubview(categoryLabel)
        addSubview(brandNameLabel)
        addSubview(productNameLabel)
//        itemView.addSubview(blurView)
//        itemView.addSubview(thankButton)
    }
    
    override func layoutSubviews() {
        itemView.frame = CGRect(x: 0, y: 0, width: width, height: height - 80)
        categoryLabel.frame = CGRect(x: 10, y: 10, width: 70, height: 40)
        brandNameLabel.frame = CGRect(x: 0, y: itemView.bottom + 10, width: width, height: 20)
        productNameLabel.frame = CGRect(x: 0, y: brandNameLabel.bottom + 10, width: width, height: 20)
        
//        blurView.frame = CGRect(x: 0, y: width, width: width, height: height - width)
        
//        let width: CGFloat = 30
//        thankButton.frame = CGRect(x: -3, y: -3, width: width, height: width)
//        thankButton.layer.cornerRadius = thankButton.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(post: Post) {
        let imageUrl = URL(string: post.imageURL)
        itemView.sd_setImage(with: imageUrl, completed: nil)
        
        brandNameLabel.text = post.title
        productNameLabel.text = post.title
    }
}
