//
//  Post.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-20.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import Foundation

struct Post {
    
    let user: User
    let imageUrl: String
    let caption: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
    
}

