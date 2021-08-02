//
//  RxModel.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation
import RxRelay

struct RxModel {
    var from: Int = 0
    var to: Int = 40
    var rxModels: BehaviorRelay<[User]> = BehaviorRelay(value: [])
}
