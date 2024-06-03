//
//  Debugging.swift
//  GitHubUser
//
//  Created by Ahmed Ezzat on 31/05/2024.
//

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}
