//
//  UserCell.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    static let id = "usercellid"
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.zPosition -= 1
        }
    }
    private var viewModel: UserCellViewModel!
    
    func setup(model: User) {
        viewModel = UserCellViewModel(user: model)
        nameLabel.text = viewModel.repoName
        usernameLabel.text = viewModel.username
        profileImageView.downloaded(from: viewModel.avatarUrl)
        idLabel.text = viewModel.id
        profileImageView.makeRounded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
}
