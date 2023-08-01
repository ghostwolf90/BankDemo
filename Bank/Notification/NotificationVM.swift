//
//  NotificationVM.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import Foundation

protocol NotificationVMInterface {
    func getNotificationList()
    var getNotificationListSubject: PublishSubject<Result<[NotificationModel]>> {get}
    
    func getNotificationListEmpty()
    var getNotificationListEmptySubject: PublishSubject<Result<[NotificationModel]>> {get}
}

class NotificationVM {
    
    var getNotificationListSubject = PublishSubject<Result<[NotificationModel]>>()
    var getNotificationListEmptySubject = PublishSubject<Result<[NotificationModel]>>()
    
    var notificationRepository: NotificationRepositoryInterface
    var disposeBag = DisposeBag()
    
    init(notificationRepository: NotificationRepositoryInterface = NotificationRepository.shared) {
        self.notificationRepository = notificationRepository
    }
    
}
extension NotificationVM: NotificationVMInterface {
    func getNotificationList() {
        notificationRepository.getNotificationList()
        .subscribe(onNext: { result in
            self.getNotificationListSubject.onNext(result)
        }, onError: { error in
            print("getNotificationListSubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
  
    func getNotificationListEmpty() {
        notificationRepository.getNotificationListEmpty()
        .subscribe(onNext: { result in
            self.getNotificationListEmptySubject.onNext(result)
        }, onError: { error in
            print("getNotificationListEmptySubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
}
