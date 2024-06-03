//
//  RepositoryTask.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
