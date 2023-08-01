//
//  AmountModel.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation

struct AmountModel {
    var account = ""
    var curr = ""
    var balance: Float = 0.0
    
    init(account: String, curr: String, balance: Float) {
        self.account = account
        self.curr = curr
        self.balance = balance
    }
}
