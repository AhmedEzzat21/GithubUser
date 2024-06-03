//
//  UsersFlowCoordinator.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation
import UIKit

protocol UsersFlowCoordinatorDependencies  {
    func makeUsersViewController(closures: UsersViewModelClosures) -> UsersViewController
    func makeUserDetailsViewController(user: User) -> UserDetailsViewController
}

class UsersFlowCoordinator {
    private let navigationController: UINavigationController
    private let dependencies: UsersFlowCoordinatorDependencies

    private weak var usersVC: UsersViewController?
    
    init(navigationController: UINavigationController,
         dependencies: UsersFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let closures = UsersViewModelClosures(showUserDetails: showUserDetails)
        let vc = dependencies.makeUsersViewController(closures: closures)

        navigationController.pushViewController(vc, animated: false)
        usersVC = vc
    }

    private func showUserDetails(user: User) {
        let vc = dependencies.makeUserDetailsViewController(user: user)
        navigationController.pushViewController(vc, animated: true)
    }
}
