//
//  Result.swift
//  LetsInstall
//
//  Created by 仲立 on 2022/8/25.
//

import Foundation

public struct Result<T>{
    public let data:T
    public let result:APIResult
    
    public var isLocal:Bool{
        return result.urlString == "local"
    }
    
    public init(data:T, result:APIResult = APIResult(urlString: "local", status: true, json: nil, error: nil, statusCode: "")) {
        self.data = data
        self.result = result
    }
}
