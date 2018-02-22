//
//  User.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-20.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
