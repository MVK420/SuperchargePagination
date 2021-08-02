//
//  User.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let description: String?
    let forks_count: Int
    let open_issues_count: Int
    let watchers_count: Int
    let score: Double
}

struct Owner: Decodable {
    let login: String
    let avatar_url: String
}
