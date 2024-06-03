//
//  RepoTableViewCell.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 02/06/2024.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    @IBOutlet weak var reponameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    func config(userRepoItemViewModel: UserRepoItemViewModel) {

        if let repoName = userRepoItemViewModel.title {
            self.reponameLbl?.text =  "Repo Name: \(repoName)"
        }
        if let description = userRepoItemViewModel.description{
            self.descriptionLbl?.text = "Description: \(description)"
        }
 
    }
}
