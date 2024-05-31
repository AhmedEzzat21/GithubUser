//
//  UsersUseCase.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation

protocol UsersUseCase {
    func fetch(cached: @escaping ([User]) -> Void,
                 completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
    func search(query: UserQuery, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
}

final class DefaultUsersUseCase: UsersUseCase {
    private let usersRepository: UsersRepository

    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func fetch(cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        return usersRepository.fetchUsers { (users) in
            cached(users)
        } completion: { (result) in
            completion(result)
        }
    }
    
    func search(query: UserQuery, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        return usersRepository.searchUsers(query: query) { (result) in
            completion(result)
        }
    }
}
