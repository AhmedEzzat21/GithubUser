//
//  ImagesRepository.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation

protocol ImagesRepository {
    func fetchImage(for user: User, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
