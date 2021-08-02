//
//  HomeFeed.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation

struct HomeFeed: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [User]
}
