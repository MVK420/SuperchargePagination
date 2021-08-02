//
//  UserCellViewModel.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation

struct UserCellViewModel {
    let id: String
    let username: String
    let repoName: String
    let avatarUrl: String
    
    init(user: User) {
        id = "\(user.id)"
        username = user.owner.login
        repoName = user.name
        avatarUrl = user.owner.avatar_url
    }
}
