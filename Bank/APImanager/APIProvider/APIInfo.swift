//
//  APIInfo.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation

//API domain
public struct APIInfo {
   
    // 最愛功能
    public static let getFavoriteList = "https://willywu0201.github.io/data/favoriteList.json"
    //訊息
    public static let getNotificationList = "https://willywu0201.github.io/data/notificationList.json"
    public static let getNotificationEmpty = "https://willywu0201.github.io/data/emptyNotificationList.json"
    //廣告
    public static let getBannerList = "https://willywu0201.github.io/data/banner.json"
    
    //Amount - First Open
    //USD
    public static let getFirstUSDSaving = "https://willywu0201.github.io/data/usdSavings1.json" //儲蓄
    public static let getFirstUSDFixedDeposited = "https://willywu0201.github.io/data/usdSavings1.json" // 定期存款
    public static let getFirstUSDDigital = "https://willywu0201.github.io/data/usdDigital1.json" //數位帳戶
    
    //KHR
    public static let getFirstKHRSaving = "https://willywu0201.github.io/data/khrSavings1.json" //儲蓄
    public static let getFirstKHRFixedDeposited = "https://willywu0201.github.io/data/khrFixed1.json" // 定期存款
    public static let getFirstKHRDigital = "https://willywu0201.github.io/data/khrDigital1.json" //數位帳戶
    
    //Amount - Pull Refresh
    //USD
    public static let getRefreshUSDSaving = "https://willywu0201.github.io/data/usdSavings2.json" //儲蓄
    public static let getRefreshUSDFixedDeposited = "https://willywu0201.github.io/data/usdSavings2.json" // 定期存款
    public static let getRefreshUSDDigital = "https://willywu0201.github.io/data/usdDigital2.json" //數位帳戶
    
    //KHR
    public static let getRefreshKHRSaving = "https://willywu0201.github.io/data/khrSavings2.json" //儲蓄
    public static let getRefreshKHRFixedDeposited = "https://willywu0201.github.io/data/khrFixed2.json" // 定期存款
    public static let getRefreshKHRDigital = "https://willywu0201.github.io/data/khrDigital2.json" //數位帳戶
   
}
