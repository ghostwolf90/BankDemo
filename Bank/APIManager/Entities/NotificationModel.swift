//
//  NotificationModel.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation


struct NotificationModel {
    var status = false
    var updateDateTime = ""
    var title = ""
    var message = ""
    
    init(status: Bool, updateDateTime: String, title: String, message: String) {
        self.status = status
        self.updateDateTime = updateDateTime
        self.title = title
        self.message = message
    }
}
