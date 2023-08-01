//
//  BannerModel.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation

struct BannerModel {
    var adSeqNo = 0
    var linkUrl = ""
    
    init(adSeqNo: Int, linkUrl: String) {
        self.adSeqNo = adSeqNo
        self.linkUrl = linkUrl
    }
}
