//
//  Models.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import Foundation

public enum UserPostType: String {
    case photo = "photo"
    case video = "video"
}

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profileImagePhoto: URL
    let birthDay: Date
    let gendr: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLikes]
    let coment: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

struct PostLikes {
    let username: String
    let postIdentifier: String
}

struct CommentLikes {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let username: String
    let creationDate: Date
    let likes: [CommentLikes]
}
