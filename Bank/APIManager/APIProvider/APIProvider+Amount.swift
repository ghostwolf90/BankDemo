//
//  APIProvider+Amount.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import Foundation

extension APIProvider {
    //USD First
    func getFirstUSDSaving() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFirstUSDSaving, headers: [:], body: [:])
    }
    
    func getFirstUSDFixedDeposited() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFirstUSDFixedDeposited, headers: [:], body: [:])
    }
    
    func getFirstUSDDigital() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFirstUSDDigital, headers: [:], body: [:])
    }
    
    //USD Pull Refresh
    func getRefreshUSDSaving() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getRefreshUSDSaving, headers: [:], body: [:])
    }
    
    func getRefreshUSDFixedDeposited() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getRefreshUSDFixedDeposited, headers: [:], body: [:])
    }
    
    func getRefreshUSDDigital() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getRefreshUSDDigital, headers: [:], body: [:])
    }
}
extension APIProvider {
    
    //KHR First
    func getFirstKHRSaving() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFirstKHRSaving, headers: [:], body: [:])
    }
    
    func getFirstKHRFixedDeposited() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFirstKHRFixedDeposited, headers: [:], body: [:])
    }
    
    func getFirstKHRDigital() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFirstKHRDigital, headers: [:], body: [:])
    }
    
    //KHR Pull Refresh
    func getRefreshKHRSaving() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getRefreshKHRSaving, headers: [:], body: [:])
    }
    
    func getRefreshKHRFixedDeposited() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getRefreshKHRFixedDeposited, headers: [:], body: [:])
    }
    
    func getRefreshKHRDigital() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getRefreshKHRDigital, headers: [:], body: [:])
    }
    
}
