//
//  Chat.swift
//  MetroMatch
//
//  Created by Reichel  Larez  on 11/28/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

struct Chat {
    
    var users: [String]
    var anonimo: Bool?
    
    var dictionary: [String: Any] {
        return [
            "users": users,
            "anonimo": anonimo
        ]
    }
}

extension Chat {
    
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
    
}
