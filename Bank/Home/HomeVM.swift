//
//  HomeVM.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import Foundation

protocol HomeVMInterface {
    func getNotificationList()
    var getNotificationListSubject: PublishSubject<Result<[NotificationModel]>> {get}
    
    //Amount First
    func getFirstUSDTotal()
    var getFirstUSDTotalSubject: PublishSubject<Float> {get}
    func getFirstKHRTotal()
    var getFirstKHRTotalSubject: PublishSubject<Float> {get}
    
    //Amount Refresh
    func getRefreshUSDTotal()
    var getRefreshUSDTotalSubject: PublishSubject<Float> {get}
    func getRefreshKHRTotal()
    var getRefreshKHRTotalSubject: PublishSubject<Float> {get}
    
    func getFavoriteList()
    var getFavoriteListSubject: PublishSubject<Result<[FavoriteModel]>> {get}
    
    func getBannerList()
    var getBannerListSubject: PublishSubject<Result<[BannerModel]>> {get}
}

class HomeVM {
    var getNotificationListSubject = PublishSubject<Result<[NotificationModel]>>()
    var getFirstUSDTotalSubject = PublishSubject<Float>()
    var getFirstKHRTotalSubject = PublishSubject<Float>()
    var getRefreshUSDTotalSubject = PublishSubject<Float>()
    var getRefreshKHRTotalSubject = PublishSubject<Float>()
    var getFavoriteListSubject = PublishSubject<Result<[FavoriteModel]>>()
    var getBannerListSubject = PublishSubject<Result<[BannerModel]>>()

    var amountRepository: AmountRepositoryInterface
    var favoriteRepository: FavoriteRepositoryInterface
    var bannerRepository: BannerRepositoryInterface
    var notificationRepository: NotificationRepositoryInterface
    
    var disposeBag = DisposeBag()
    
    init(amountRepository: AmountRepositoryInterface = AmountRepository.shared,
         favoriteRepository: FavoriteRepositoryInterface = FavoriteRepository.shared,
         bannerRepository: BannerRepositoryInterface = BannerRepository.shared,
         notificationRepository: NotificationRepositoryInterface = NotificationRepository.shared) {
        self.amountRepository = amountRepository
        self.favoriteRepository = favoriteRepository
        self.bannerRepository = bannerRepository
        self.notificationRepository = notificationRepository
    }
    
}
extension HomeVM: HomeVMInterface {
    
    func getNotificationList() {
        notificationRepository.getNotificationList()
        .subscribe(onNext: { result in
            self.getNotificationListSubject.onNext(result)
        }, onError: { error in
            print("getNotificationListSubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
    func getFirstUSDTotal() {
        amountRepository.getFirstUSDTotal()
        .subscribe(onNext: { result in
            self.getFirstUSDTotalSubject.onNext(result)
        }, onError: { error in
            print("getFirstUSDTotalSubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
    func getRefreshUSDTotal() {
        amountRepository.getRefreshUSDTotal()
        .subscribe(onNext: { result in
            self.getRefreshUSDTotalSubject.onNext(result)
        }, onError: { error in
            print("getRefreshUSDTotalSubject Error: \(error)")
        }).disposed(by: disposeBag)        
    }
    
    func getFirstKHRTotal() {
        amountRepository.getFirstKHRTotal()
        .subscribe(onNext: { result in
            self.getFirstKHRTotalSubject.onNext(result)
        }, onError: { error in
            print("getFirstKHRTotalSubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
    func getRefreshKHRTotal() {
        amountRepository.getRefreshKHRTotal()
        .subscribe(onNext: { result in
            self.getRefreshKHRTotalSubject.onNext(result)
        }, onError: { error in
            print("getRefreshKHRTotalSubject Error: \(error)")
        }).disposed(by: disposeBag)
        
    }
    
    func getBannerList() {
        bannerRepository.getBannerList()
        .subscribe(onNext: { result in
            self.getBannerListSubject.onNext(result)
        }, onError: { error in
            print("getBannerListSubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
    
    func getFavoriteList() {
        favoriteRepository.getFavoriteList()
        .subscribe(onNext: { result in
            self.getFavoriteListSubject.onNext(result)
        }, onError: { error in
            print("getFavoriteListSubject Error: \(error)")
        }).disposed(by: disposeBag)
    }
    
    
}
