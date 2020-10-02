//
//  CollectionViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/10/01.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class SDGsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SDGsCollectionViewCell"
    
    public let cellImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cellImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.frame = bounds
    }
}
