//
//  FavoriteProvider.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import SwiftyJSON
import Foundation

protocol FavoriteRepositoryInterface {
    
    func getFavoriteList() -> Observable<Result<[FavoriteModel]>>
    
}

class FavoriteRepository {
    public static let shared = FavoriteRepository()
    private let disposeBag = DisposeBag()
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider = APIProvider.shared) {
        self.apiProvider = apiProvider
    }
    
}
extension FavoriteRepository: FavoriteRepositoryInterface {
    
    func getFavoriteList() -> Observable<Result<[FavoriteModel]>> {
        let subject = PublishSubject<Result<[FavoriteModel]>>()
        apiProvider.getFavoriteList()
        .subscribe(onNext: { apiResult in
            guard let datas = apiResult.json?["result"]["favoriteList"].arrayValue else { return }
            let favoriteList = datas.map { (json) -> FavoriteModel in
                let nickname = json["nickname"].stringValue 
                let transType = json["transType"].stringValue
                return FavoriteModel(nickname: nickname, transType: transType)
            }
            let result = Result<[FavoriteModel]>(data: favoriteList, result: apiResult)
            subject.onNext(result)
        }, onError: { error in
            subject.onError(error)
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
}
