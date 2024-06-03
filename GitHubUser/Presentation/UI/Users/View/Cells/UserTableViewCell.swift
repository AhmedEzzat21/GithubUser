//
//  UserTableViewCell.swift
//  GitHubUser
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
        confiUI()
        if let image = userItemViewModel.user?.image {
            self.avatar?.image = UIImage(data: image)
        }
        if let userName = userItemViewModel.user?.login {
            self.usernameLbl?.text =  "Name: \(userName)"
        }
        if let repoNumber = userItemViewModel.user?.reposURL?.count {
            self.repoNumLbl?.text = "Repositories: \(repoNumber)"
        }
        if let followers = userItemViewModel.user?.followersURL?.count {
            self.followersLbl?.text = "Followers: \(followers)"
        }
    }
    func confiUI(){
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
    }
}
