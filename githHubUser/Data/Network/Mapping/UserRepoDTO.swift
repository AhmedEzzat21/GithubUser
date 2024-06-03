//
//  UserRepoDTO.swift
//  githHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

import Foundation
import CoreData

// MARK: - Data Transfer Object
struct UserRepoDTO: Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var html_url: String?
}

//MARK: - Domain To Mapping
extension Repo {
    func toDTO() -> UserRepoDTO {
        return .init(id: id, name: name, description: description, html_url: html_url)
    }
}

// MARK: - Mappings to Domain
extension UserRepoDTO {
    func mapToDomain() -> Repo {
        return .init(id: id,
                     name: name,
                     description: description, html_url: html_url)
    }
}

//MARK: - Mapping to Entity
extension UserRepoDTO {
    func toEntity(in context: NSManagedObjectContext) -> UserRepoEntity {
        let entity: UserRepoEntity = .init(context: context)
        entity.id = Int64(id!)
        entity.name = name
        entity.descriptionn = description
        entity.html_url = html_url
        return entity
    }
}

//MARK: - Mapping to Data Transfer Object
extension UserRepoEntity {
    func toDTO() -> UserRepoDTO {
        return .init(id: Int(id),
                     name: name,
                     description: descriptionn, html_url: html_url)
    }
}
