//
//  Post.swift
//  MetroMatch
//
//  Created by Edward Pizzurro Fortun on 10/24/20.
//  Copyright © 2020 Edwjon. All rights reserved.
//

import UIKit


class Post: NSObject {
    public var profilePic: String?
    public var comments: [String]?
    public var username: String?
    public var descripcion: String?
    public var compatibility: Int?
    public var usernameCreator: String?
    public var creatorProfilePic: String?
    public var creatorID: String?
    public var id: String?
    public var matched: Bool?
    public var anonymous: Bool?
    public var date: Date?
}
