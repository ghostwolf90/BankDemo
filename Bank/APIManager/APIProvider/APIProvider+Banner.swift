//
//  APIProvider+Banner.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import Foundation

extension APIProvider {
    
    /// NotificationList
    func getBannerList() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getBannerList, headers: [:], body: [:])
    }
}
