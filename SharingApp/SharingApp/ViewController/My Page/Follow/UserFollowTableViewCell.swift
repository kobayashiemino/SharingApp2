//
//  ListViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/09.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserRelationship)
}

enum FollowState {
    case following, not_Following
}

struct UserRelationship {
    let username: String
    let name: String
    let followType: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "ListViewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 5
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(profileImageView)
        addSubview(followButton)
        addSubview(usernameLabel)
        addSubview(nameLabel)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 5,
                                      y: 5,
                                      width: contentView.height - 10,
                                      height: contentView.height - 10)
        let buttonWidth = contentView.width > 500 ? 220 : contentView.width / 3
        followButton.frame = CGRect(x: contentView.width - 100,
                                    y: 15,
                                    width: buttonWidth,
                                    height: contentView.height - 30)
        let labelHeight = contentView.height / 2
        usernameLabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: 0,
                                     width: contentView.width - 3 - profileImageView.width,
                                     height: labelHeight)
        nameLabel.frame = CGRect(x: profileImageView.right + 5,
                                 y: usernameLabel.bottom,
                                     width: contentView.width - 3 - profileImageView.width,
                                     height: labelHeight)
    }
    
    public func configure(model: UserRelationship) {
        
        self.model = model
        
        usernameLabel.text = model.username
        nameLabel.text = model.name
        
        switch model.followType {
        case .following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.link.cgColor
        case .not_Following:
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    @objc private func didTapFollowButton() {
        
        guard let model = model else { return }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
