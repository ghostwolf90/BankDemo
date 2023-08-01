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

protocol AmountRepositoryInterface {
    
    func getFirstUSDTotal() -> Observable<Float>
    func getFirstKHRTotal() -> Observable<Float>
    
    func getRefreshUSDTotal() -> Observable<Float>
    func getRefreshKHRTotal() -> Observable<Float>
    
}

class AmountRepository {
    public static let shared = AmountRepository()
    private let disposeBag = DisposeBag()
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider = APIProvider.shared) {
        self.apiProvider = apiProvider
    }
}
extension AmountRepository: AmountRepositoryInterface {
    
    func getFirstUSDTotal() -> RxSwift.Observable<Float> {
        let subject = PublishSubject<Float>()
        Observable.zip(apiProvider.getFirstUSDSaving(),
                       apiProvider.getFirstUSDFixedDeposited(),
                       apiProvider.getFirstUSDDigital())
        .subscribe(onNext: { savingResult, depositedResult, digitalResult in
            guard let savingsDatas = savingResult.json?["result"]["savingsList"].arrayValue else { return }
            let savings = savingsDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let depositDatas = depositedResult.json?["result"]["fixedDepositList"].arrayValue else { return }
            let deposits = depositDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let digitalDatas = digitalResult.json?["result"]["digitalList"].arrayValue else { return }
            let digitals = digitalDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            let totalSavings = savings.reduce(0.0) { $0 + $1.balance }
            let totalDeposits = deposits.reduce(0.0) { $0 + $1.balance }
            let totalDigitals = digitals.reduce(0.0) { $0 + $1.balance }
            
            let total = totalSavings + totalDeposits + totalDigitals
            subject.onNext(total)
        }, onError: { (error) in
            print("getFirstUSDTotal Error: \(error)")
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
    func getRefreshUSDTotal() -> Observable<Float> {
        let subject = PublishSubject<Float>()
        Observable.zip(apiProvider.getRefreshUSDSaving(),
                       apiProvider.getRefreshUSDFixedDeposited(),
                       apiProvider.getRefreshUSDDigital())
        .subscribe(onNext: { savingResult, depositedResult, digitalResult in
            guard let savingsDatas = savingResult.json?["result"]["savingsList"].arrayValue else { return }
            let savings = savingsDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let depositDatas = depositedResult.json?["result"]["fixedDepositList"].arrayValue else { return }
            let deposits = depositDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let digitalDatas = digitalResult.json?["result"]["digitalList"].arrayValue else { return }
            let digitals = digitalDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            let totalSavings = savings.reduce(0.0) { $0 + $1.balance }
            let totalDeposits = deposits.reduce(0.0) { $0 + $1.balance }
            let totalDigitals = digitals.reduce(0.0) { $0 + $1.balance }
            
            let total = totalSavings + totalDeposits + totalDigitals
            subject.onNext(total)
        }, onError: { (error) in
            print("getFirstUSDTotal Error: \(error)")
        }).disposed(by: disposeBag)
        return subject.asObserver()
        
    }
    
    func getFirstKHRTotal() -> Observable<Float> {
        let subject = PublishSubject<Float>()
        Observable.zip(apiProvider.getFirstKHRSaving(),
                       apiProvider.getFirstKHRFixedDeposited(),
                       apiProvider.getFirstKHRDigital())
        .subscribe(onNext: { savingResult, depositedResult, digitalResult in
            guard let savingsDatas = savingResult.json?["result"]["savingsList"].arrayValue else { return }
            let savings = savingsDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let depositDatas = depositedResult.json?["result"]["fixedDepositList"].arrayValue else { return }
            let deposits = depositDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let digitalDatas = digitalResult.json?["result"]["digitalList"].arrayValue else { return }
            let digitals = digitalDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            let totalSavings = savings.reduce(0.0) { $0 + $1.balance }
            let totalDeposits = deposits.reduce(0.0) { $0 + $1.balance }
            let totalDigitals = digitals.reduce(0.0) { $0 + $1.balance }
            
            let total = totalSavings + totalDeposits + totalDigitals
            subject.onNext(total)
        }, onError: { (error) in
            print("getFirstUSDTotal Error: \(error)")
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
    func getRefreshKHRTotal() -> Observable<Float> {
        let subject = PublishSubject<Float>()
        Observable.zip(apiProvider.getRefreshKHRSaving(),
                       apiProvider.getRefreshKHRFixedDeposited(),
                       apiProvider.getRefreshKHRDigital())
        .subscribe(onNext: { savingResult, depositedResult, digitalResult in
            guard let savingsDatas = savingResult.json?["result"]["savingsList"].arrayValue else { return }
            let savings = savingsDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let depositDatas = depositedResult.json?["result"]["fixedDepositList"].arrayValue else { return }
            let deposits = depositDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            guard let digitalDatas = digitalResult.json?["result"]["digitalList"].arrayValue else { return }
            let digitals = digitalDatas.map { (json) -> AmountModel in
                let balance = json["balance"].floatValue
                return AmountModel(account: "", curr: "", balance: balance)
            }
            let totalSavings = savings.reduce(0.0) { $0 + $1.balance }
            let totalDeposits = deposits.reduce(0.0) { $0 + $1.balance }
            let totalDigitals = digitals.reduce(0.0) { $0 + $1.balance }
            
            let total = totalSavings + totalDeposits + totalDigitals
            subject.onNext(total)
        }, onError: { (error) in
            print("getFirstUSDTotal Error: \(error)")
        }).disposed(by: disposeBag)
        return subject.asObserver()
    }
    
    
}
