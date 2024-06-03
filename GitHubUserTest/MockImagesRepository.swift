//
//  MockImagesRepository.swift
//  GitHubUserTests
//
//  Created by Ahmed Ezzat on 03/06/2024.
//

import Foundation
import XCTest
@testable import GitHubUser


class MockImagesRepository: ImagesRepository {
    var fetchImageResult: Result<Data, Error>?

    func fetchImage(for user: User, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        if let result = fetchImageResult {
            completion(result)
        }
        return nil
    }
}
