//
//  NotificationLikeEventTableViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/09.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    public var delegate: NotificationLikeEventTableViewCellDelegate?
    
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
        label.backgroundColor = .white
        label.text = "@Joe like your photo"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(profileImageView)
        addSubview(label)
        addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for:.touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else { return }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumnailImage
            guard !thumbnail.absoluteString.contains("google.com") else { return }
            postButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
        case .follow:
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profileImagePhoto, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size = contentView.height - 4
        postButton.frame = CGRect(x: contentView.width - size,
                                  y: 2,
                                  width: size,
                                  height: size)
        label.frame = CGRect(x: profileImageView.right,
                             y: 0,
                             width: contentView.width - size - profileImageView.width - 6,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        profileImageView.image = nil
        postButton.setBackgroundImage(nil, for: .normal)
    }
}
