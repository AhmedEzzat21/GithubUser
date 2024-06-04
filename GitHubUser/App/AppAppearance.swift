//
//  AppAppearance.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation
import UIKit

class AppAppearance {
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .gray
        UINavigationBar.appearance().tintColor = .gray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
