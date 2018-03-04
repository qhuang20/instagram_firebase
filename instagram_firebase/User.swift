//
//  User.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-20.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
