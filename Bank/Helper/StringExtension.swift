//
//  StringExtension.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation

extension String {
    
    ///金額: 加千分位 ＆ 小數點後兩位
    var amount: String {
        let number: NSNumber = NSNumber(value: Float(self) ?? 0)
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.roundingMode = .down
        formatter.groupingSeparator = ","
        return formatter.string(from: number) ?? ""
    }
}
