//
//  BannerRepository.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import SwiftyJSON
import Foundation

protocol BannerRepositoryInterface {
    
    func getBannerList() -> Observable<Result<[BannerModel]>>
    
}

class BannerRepository {
    public static let shared = BannerRepository()
    private let disposeBag = DisposeBag()
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider = APIProvider.shared) {
        self.apiProvider = apiProvider
    }
}
extension BannerRepository: BannerRepositoryInterface {
    
    func getBannerList() -> RxSwift.Observable<Result<[BannerModel]>> {
        let subject = PublishSubject<Result<[BannerModel]>>()
        apiProvider.getBannerList()
        .subscribe(onNext: { apiResult in
            guard let datas = apiResult.json?["result"]["bannerList"].arrayValue else { return }
            let favoriteList = datas.map { (json) -> BannerModel in
                let adSeqNo = json["adSeqNo"].intValue
                let linkUrl = json["linkUrl"].stringValue
                return BannerModel(adSeqNo: adSeqNo, linkUrl: linkUrl)
            }
            let result = Result<[BannerModel]>(data: favoriteList, result: apiResult)
            subject.onNext(result)
        }, onError: { error in
            subject.onError(error)
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
    
}
