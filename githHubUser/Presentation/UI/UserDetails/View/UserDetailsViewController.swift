//
//  UserDetailsViewController.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    private var viewModel: UserDetailsViewModel!
    private var repos: [UserRepoItemViewModel] = []
    
    static func create(with viewModel: UserDetailsViewModel) -> UserDetailsViewController {
        let view = UserDetailsViewController(nibName: "UserDetailsViewController", bundle: nil)
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDIdLoad()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        bind(to: viewModel)
    }

    private func bind(to viewModel: UserDetailsViewModel) {
        viewModel.repos.observe(on: self) { [weak self] repos in
            self?.repos = repos
            self?.tableView.reloadData()
        }
        viewModel.followingInfo.observe(on: self) { [unowned self] (following) in
            self.followingLabel.text = "Following: \(following)"
        }
        viewModel.image.observe(on: self) { [unowned self] (image) in
            if let image = image {
                self.imageView.image = UIImage(data: image)
            }
        }
        viewModel.followersInfo.observe(on: self) { [unowned self] (followers) in
            self.followersLabel.text =  "Followers: \(followers)"
        }
        viewModel.title.observe(on: self) { [unowned self] (title) in
            self.loginName.text =  "Name: \(title)"
        }
        viewModel.error.observe(on: self) { [unowned self] (error) in
            if let err = error {
                self.showAlert(message: err)
            }
        }
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell") as! RepoTableViewCell
        cell.config(userRepoItemViewModel: repos[indexPath.row])
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let safeUrlStr = self.repos[indexPath.row].forks_url {
//            if let safeUrl = URL(string: safeUrlStr) {
//                UIApplication.shared.open(safeUrl)
//            }
//        }
//        self.tableView.deselectRow(at: indexPath, animated: true);
//    }
}

