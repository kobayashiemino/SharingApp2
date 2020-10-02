//
//  NotificationFolloeEventTableViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/09.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFolloeEventTableViewCell"
    
    public var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds =  true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .label
        label.text = "@kany started following you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(profileImageView)
        addSubview(label)
        addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapFollowButton() {
           guard let model = model else { return }
           delegate?.didTapFollowUnfollowButton(model: model)
       }
       
       public func configure(with model: UserNotification) {
           self.model = model
           
           switch model.type {
           case .like(_):
               break
           case .follow(let state):
            switch state {
            case .following:
                configureForFollow()
            case .not_Following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.layer.backgroundColor = UIColor.link.cgColor
            }
           }
           
           label.text = model.text
           profileImageView.sd_setImage(with: model.user.profileImagePhoto, completed: nil)
       }
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size: CGFloat = 100
        followButton.frame = CGRect(x: contentView.width - size,
                                    y: (contentView.height - 44) / 2,
                                  width: size,
                                  height: 44)
        
        label.frame = CGRect(x: profileImageView.right,
                             y: 0,
                             width: contentView.width - size - profileImageView.width - 6,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        profileImageView.image = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
}
