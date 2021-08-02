//
//  DetailViewController.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.makeRounded()
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    var viewModel: DetailViewModel!
    var model: User! {
        didSet {
            viewModel = DetailViewModel(from: model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        repoNameLabel.text = viewModel.repoName
        userNameLabel.text = viewModel.userName
        avatarImageView.downloaded(from: viewModel.avatarUrl)
        descriptionLabel.text = viewModel.description
        scoreLabel.text = viewModel.score
        issuesLabel.text = viewModel.openIssuesCount
        forksLabel.text = viewModel.forksCount
        watchersLabel.text = viewModel.watchersCount
    }
}
