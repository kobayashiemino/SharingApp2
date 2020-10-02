//
//  NotificationViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/09.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

class NotificationViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.isHidden = true
        tableView.register(NotificationFollowEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        tableView.register(NotificationLikeEventTableViewCell.self,
                           forCellReuseIdentifier:NotificationLikeEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var models = [UserNotification]()
        
    private lazy var noNotificationView = NoNotificationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapCancel))
        fetchNotifications()
        view.backgroundColor = .white
        
        view.addSubview(spinner)
//        spinner.startAnimating()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        addNoNotificationsView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0..<100 {
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumnailImage: URL(string: "https://www.google.com/")!,
                                postURL: URL(string: "https://www.google.com/")!,
                                caption: nil,
                                likeCount: [],
                                coment: [],
                                createdDate: Date(),
                                taggedUsers: [])
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .following),
                                         text: "Hello World",
                                         user: User(username: "joe",
                                                    bio: "",
                                                    name: (first: "", last: ""),
                                                    profileImagePhoto: URL(string:"https://www.google.com/")!,
                                                    birthDay: Date(),
                                                    gendr: .male,
                                                    counts: UserCount(followers: 1, following: 1, posts: 1),
                                                    joinDate: Date()))
            models.append(model)
        }
    }
    
    private func addNoNotificationsView() {
        view.addSubview(noNotificationView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.height / 4)
        noNotificationView.center = view.center
        noNotificationView.isHidden = true
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let model = models[indexPath.row]
        
        switch model.type {
            
        case .like(post: _):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
//        switch model.type {
//        case .like(let post):
//            let vc = ProductDetailViewController(post: post)
//            vc.title = post.postType.rawValue
//            navigationController?.pushViewController(vc, animated: true)
//        case .follow(_):
//            fatalError("Dev issue: should never get cold ")
//        }
    }
}

extension NotificationViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("didTapFollowUnfollowButton")
    }
}
