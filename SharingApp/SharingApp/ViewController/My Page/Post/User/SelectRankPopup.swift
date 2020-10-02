//
//  RankView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/06.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol SelectRankPopupDelegate: AnyObject {
    func didSelectRankButton()
}

class SelectRankPopup: UIView {
    
    public weak var delegate: SelectRankPopupDelegate?
    
    private let goldButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        return button
    }()
    
    private let silverButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        return button
    }()
    
    private let copperButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        return button
    }()
    
    private var stackView: UIStackView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView = UIStackView(arrangedSubviews: [goldButton, silverButton, copperButton])
        stackView?.axis = .horizontal
        stackView?.distribution = .fillEqually
        stackView?.spacing = 35
        stackView?.backgroundColor = .link
        if let stackView = stackView {
            addSubview(stackView)
        }
        
        goldButton.addTarget(self, action: #selector(didTapRankButton), for: .touchUpInside)
        silverButton.addTarget(self, action: #selector(didTapRankButton), for: .touchUpInside)
        copperButton.addTarget(self, action: #selector(didTapRankButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView?.frame = CGRect(x: (self.width - 280) / 2,
                                  y: (self.height - 70) / 2,
                                  width: 280,
                                  height: 70)
        goldButton.layer.cornerRadius = goldButton.width / 2
        silverButton.layer.cornerRadius = goldButton.width / 2
        copperButton.layer.cornerRadius = goldButton.width / 2
    }
    
    @objc private func didTapRankButton() {
        delegate?.didSelectRankButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
