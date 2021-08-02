//
//  GithubService.swift
//  SuperchargeHazi
//
//  Created by Mozes Vidami on 7/13/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class GithubService {
    static let shared = GithubService()
    private init() { }

    func getUsers(from: Int, to: Int) -> Single<[User]> {
        return Single.create { me in
            let url = URL(string: "https://api.github.com/search/repositories?q=+language:swift&sort=stars&order=desc&page=\(from)&per_page=\(to)&accesstoken=\(Constants.apiKey)")!
            let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let data = data, let parsedData = self.parse(data, to: HomeFeed.self) {
                    me(.success(parsedData.items))
                } else {
                    me(.failure("Couldn't get data" as! Error))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func parse<T: Decodable>(_ data: Data, to type: T.Type)->T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Parsing error! \(error)")
            return nil
        }
    }
}
