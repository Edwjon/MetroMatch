//
//  User.swift
//  MetroMatch
//
//  Created by Reichel  Larez  on 10/28/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit

class User: NSObject {
    @objc var firstName: String?
    @objc var lastName: String?
    @objc var email: String?
    @objc var aboutMe: [String: Any]?
    @objc var id: String?
    @objc var matches: [String: Any]?
    @objc var notifications: [String: Any]?
    @objc var phone: String?
    @objc var posts: [String: Any]?
    @objc var username: String?
}
