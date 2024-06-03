//
//  MockUsersUseCase.swift
//  GitHubUserTests
//
//  Created by Ahmed Ezzat on 03/06/2024.
//

import Foundation
import XCTest
@testable import GitHubUser

class MockUsersUseCase: UsersUseCase {
    var fetchResult: Result<[User], Error>?
    var searchResult: Result<[User], Error>?
    var fetchClosure: ((@escaping (Result<[User], Error>) -> Void) -> Cancellable?)?
    func fetch(cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
           if let fetchClosure = fetchClosure {
               return fetchClosure(completion)
           }
           if let result = fetchResult {
               completion(result)
           }
           return nil
       }

    func search(query: UserQuery, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        if let result = searchResult {
            completion(result)
        }
        return nil
    }
}
