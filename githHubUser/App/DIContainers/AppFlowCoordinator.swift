//
//  AppFlowCoordinator.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation
import UIKit

class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        self.showUsers()
    }
    
    func showUsers() {
        let usersSceneDIContainer = appDIContainer.makeUsersSceneDIContainer()
        let flow = usersSceneDIContainer.makeUsersFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
