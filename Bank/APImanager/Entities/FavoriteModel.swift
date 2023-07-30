//
//  favoriteModel.swift
//  Bank
//
//  Created by 仲立 on 2023/7/30.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation

struct FavoriteModel {
    var nickname = ""
    var transType = ""
    
    init(nickname: String, transType: String) {
        self.nickname = nickname
        self.transType = transType
    }
}
