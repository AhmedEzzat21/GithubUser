//
//  UserItemViewModel.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation
import UIKit

class UserItemViewModel {
    var userName: Observable<String> = Observable("")
    var repoNumber: Observable<String> = Observable("")
    var followers: Observable<String> = Observable("")
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
}

extension UserItemViewModel {
    func viewDidLoad() {
        if let user = user {
            userName.value = user.login ?? ""
            repoNumber.value = "\(user.repos?.count ?? 0)"
            followers.value = "\(user.followers?.count ?? 0)"
        }
    }
}
