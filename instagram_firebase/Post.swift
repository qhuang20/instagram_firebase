//
//  Post.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-20.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
