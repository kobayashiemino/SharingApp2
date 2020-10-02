//
//  SDGsViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/10/01.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol SDGsViewDelegate: AnyObject {
    func didTapSDGsButton(number: [Int])
}

class SDGsView: UIView {
    
    private var collectionView: UICollectionView?
    
    public weak var delegate: SDGsViewDelegate?
    
    private let SDGsImages: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    
    private var selectedSDGs = [Int]()
    
    private let finishSelectSDGsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        let cellWidth = (width - 20) / 3
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if let collectionView = collectionView {
            collectionView.backgroundColor = .white
            self.addSubview(collectionView)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(SDGsCollectionViewCell.self, forCellWithReuseIdentifier: SDGsCollectionViewCell.identifier)
        }
        
        addSubview(finishSelectSDGsButton)
        finishSelectSDGsButton.addTarget(self, action: #selector(didTapFinishSDGsButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        finishSelectSDGsButton.frame = CGRect(x: width - 90, y: height - 90, width: 60, height: 60)
        finishSelectSDGsButton.layer.cornerRadius = finishSelectSDGsButton.width / 2
    }
    
    @objc private func didTapFinishSDGsButton() {
        delegate?.didTapSDGsButton(number: selectedSDGs)
    }
}

extension SDGsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SDGsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SDGsCollectionViewCell.identifier, for: indexPath) as! SDGsCollectionViewCell
        cell.cellImageView.image = UIImage(named: "\(SDGsImages[indexPath.row])")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSDGs.append(indexPath.row + 1)
    }
}
