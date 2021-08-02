//
//  DetailViewModel.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation

struct DetailViewModel {
    let repoName: String
    let userName: String
    let avatarUrl: String
    let description: String
    let forksCount: String
    let openIssuesCount: String
    let watchersCount: String
    let score: String
    
    init(from model: User) {
        repoName = model.name
        userName = model.owner.login
        avatarUrl = model.owner.avatar_url
        description = model.description ?? ""
        forksCount = String(model.forks_count)
        openIssuesCount = String(model.open_issues_count)
        watchersCount = String(model.watchers_count)
        score = String(model.score)
    }
}
