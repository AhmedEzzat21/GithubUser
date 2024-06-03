//
//  User.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation
import UIKit

struct User {
    var id: Int?
    var login: String?
    var avatarURL: String?
    var followersURL: String?
    var followingURL: String?
    var reposURL: String?
    
    var following: [User]?
    var followers: [User]?
    var repos: [Repo]?
    
    var image: Data?
}
