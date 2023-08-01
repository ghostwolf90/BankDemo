//
//  NotificationRepository.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import SwiftyJSON
import Foundation

protocol NotificationRepositoryInterface {
    
    func getNotificationList() -> Observable<Result<[NotificationModel]>>
    
    func getNotificationListEmpty() -> Observable<Result<[NotificationModel]>>
    
}

class NotificationRepository {
    
    public static let shared = NotificationRepository()
    private let disposeBag = DisposeBag()
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider = APIProvider.shared) {
        self.apiProvider = apiProvider
    }
    
}
extension NotificationRepository: NotificationRepositoryInterface {
    
    func getNotificationList() -> Observable<Result<[NotificationModel]>> {
        let subject = PublishSubject<Result<[NotificationModel]>>()
        apiProvider.getNotificationList()
        .subscribe(onNext: { apiResult in
            guard let datas = apiResult.json?["result"]["messages"].arrayValue else { return }
            let notificationList = datas.map { (json) -> NotificationModel in
                let status          = json["status"].boolValue
                let updateDateTime  = json["updateDateTime"].stringValue
                let title           = json["title"].stringValue
                let message         = json["message"].stringValue
                
                return NotificationModel(status: status,
                                         updateDateTime: updateDateTime,
                                         title: title,
                                         message: message)
            }
            let result = Result<[NotificationModel]>(data: notificationList, result: apiResult)
            subject.onNext(result)
        }, onError: { error in
            subject.onError(error)
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
    func getNotificationListEmpty() -> Observable<Result<[NotificationModel]>> {
        let subject = PublishSubject<Result<[NotificationModel]>>()
        apiProvider.getNotificationListEmpty()
        .subscribe(onNext: { apiResult in
            guard let datas = apiResult.json?["result"]["messages"].arrayValue else { return }
            let notificationList = datas.map { (json) -> NotificationModel in
                let status          = json["status"].boolValue
                let updateDateTime  = json["updateDateTime"].stringValue
                let title           = json["title"].stringValue
                let message         = json["message"].stringValue
                
                return NotificationModel(status: status,
                                         updateDateTime: updateDateTime,
                                         title: title,
                                         message: message)
            }
            let result = Result<[NotificationModel]>(data: notificationList, result: apiResult)
            subject.onNext(result)
        }, onError: { error in
            subject.onError(error)
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
    
}
