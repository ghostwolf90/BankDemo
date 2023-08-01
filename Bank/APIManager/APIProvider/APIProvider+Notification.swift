//
//  APIProvider+Notification.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import RxSwift
import Foundation

extension APIProvider {
    
    /// NotificationList
    func getNotificationList() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getNotificationList, headers: [:], body: [:])
    }
    
    func getNotificationListEmpty() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getNotificationEmpty, headers: [:], body: [:])
    }
    

}
