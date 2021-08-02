//
//  UsersViewController.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class UsersViewController: UIViewController {
    
    @IBOutlet private weak var userTableView: UITableView!
    let vcModel: RxModel = RxModel()
    private let disposeBag: DisposeBag = DisposeBag()
    private var selectedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        bindTableView()
    }
    
    private func bindTableView() {
        vcModel.rxModels.bind(to: self.userTableView.rx.items(cellIdentifier: UserCell.id,
                                                              cellType: UserCell.self)) {
                                                                    (index, user: User, cell) in
                                                                    cell.setup(model: user)
        }.disposed(by: disposeBag)
        
        userTableView.rx.modelSelected(User.self)
            .subscribe(onNext: { [weak self] tappedUser in
                guard let self = self else { return }
                self.selectedUser = tappedUser
                self.performSegue(withIdentifier: "toDetailSegue", sender: self)
                // Deselect row
                if let selectedRowIndexPath = self.userTableView.indexPathForSelectedRow {
                    self.userTableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchData() {
        GithubService.shared.getUsers(from: vcModel.from, to: vcModel.to)
            .subscribe(onSuccess: { [weak self] users in
                self?.vcModel.rxModels.accept(users)
            }, onFailure: { error in
                print("Error ", error.localizedDescription)
            }, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailViewController else { return }
        controller.model = self.selectedUser
    }
    
    // Attempting to make pagination work. Don't look at this
    //
    //
    //
    private func pagination() {
        var pageIndex: Int = 0
        var isAllLoaded = false
        let loadNextPageTrigger = PublishSubject<Void>()
        let loading = BehaviorSubject<Bool>(value: false)
        let nextPage = BehaviorRelay<[User]>(value: [])
        
        let _ = loading.asObservable()
            .sample(loadNextPageTrigger)
            .flatMap { loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    guard !isAllLoaded else { return Observable.empty() }
                    return Observable<Int>.create { observer in
                        pageIndex += 20
                        print(pageIndex)
                        observer.onNext(pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }
        
        let _ = Observable.combineLatest(nextPage, vcModel.rxModels, resultSelector: { request, response in
            //self.isAllLoaded = response.count < 20 // here the check
            // if self.pageIndex == 0 {
            return self.vcModel.rxModels.value
            //}
        }
        ).bind(to: self.userTableView.rx.items(cellIdentifier: UserCell.id,
                                               cellType: UserCell.self)) {
            (index, user: User, cell) in
            cell.setup(model: user)
        }.disposed(by: disposeBag)
    }
}
