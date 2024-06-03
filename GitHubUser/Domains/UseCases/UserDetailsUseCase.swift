//
//  UserDetailsUseCase.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation

protocol UserDetailsUseCase {
    func fetchFollowers(
        for user: User,
        cached: @escaping ([User]) -> Void,
        completion: @escaping (Result<[User], Error>) -> Void
    ) -> Cancellable?
    
    func fetchFollowing(
        for user: User,
        cached: @escaping ([User]) -> Void,
        completion: @escaping (Result<[User], Error>) -> Void
    ) -> Cancellable?
    
    func fetchRepos(
        for user: User,
        cached: @escaping ([Repo]) -> Void,
        completion: @escaping (Result<[Repo], Error>) -> Void
    ) -> Cancellable?
    
}

final class UserDetailsUseCaseImpl: UserDetailsUseCase {
    private let usersRepository: UsersRepository

    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func fetchFollowers(
        for user: User,
        cached: @escaping ([User]) -> Void,
        completion: @escaping (Result<[User], Error>) -> Void
    ) -> Cancellable? {
        
        return usersRepository.getFollowers(for: user) { (users) in
            cached(users)
        } completion: { (result) in
            completion(result)
        }
    }
    
    func fetchFollowing(
        for user: User,
        cached: @escaping ([User]) -> Void,
        completion: @escaping (Result<[User], Error>) -> Void
    ) -> Cancellable? {
        
        return usersRepository.getFollowing(for: user) { (users) in
            cached(users)
        } completion: { (result) in
            completion(result)
        }
    }
    
    func fetchRepos(
        for user: User,
        cached: @escaping ([Repo]) -> Void,
        completion: @escaping (Result<[Repo], Error>) -> Void
    ) -> Cancellable? {
        
        return usersRepository.getRepos(for: user) { (repos) in
            cached(repos)
        } completion: { (result) in
            completion(result)
        }
    }
}
