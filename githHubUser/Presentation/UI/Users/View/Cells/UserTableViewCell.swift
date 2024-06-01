//
//  UserTableViewCell.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var repoNumLbl: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var avatar: UIImageView!

    func config(userItemViewModel: UserItemViewModel) {
        if let image = userItemViewModel.user?.image {
            self.avatar?.image = UIImage(data: image)
        }
        if let userName = userItemViewModel.user?.login {
            self.usernameLbl?.text =  "User Name: \(userName)"
        }
        if let repoNumber = userItemViewModel.user?.reposURL?.count {
            self.repoNumLbl?.text = "Number of public repositories: \(repoNumber)"
        }
        if let followers = userItemViewModel.user?.followersURL?.count {
            self.followersLbl?.text = "Followers: \(followers)"
        }
    }
}
