//
//  SuggestModel.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/27.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

public struct Suggest {
    let title: String
    let detail: String
//    let themeImage: suggestTheme
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.detail = dictionary["detail"] as? String ?? ""
//        self.themeImage = dictionary["suggestTheme"] as? suggestTheme ?? suggestTheme.favorite
    }
}

//public enum suggestTheme {
//    case favorite, trouble
//}

