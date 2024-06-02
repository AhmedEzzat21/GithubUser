//
//  MockCancellable.swift
//  githHubUserTests
//
//  Created by Ahmed Ezzat on 03/06/2024.
//

import Foundation
import XCTest
@testable import githHubUser
class MockCancellable: Cancellable {
    var isCancelled = false
    func cancel() {
        isCancelled = true
    }
}
