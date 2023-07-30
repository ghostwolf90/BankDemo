//
//  APIManager.swift
//  TigerModelKit
//
//  Created by Randy_Syu on 2020/11/13.
//  Copyright © 2020 Randy_Syu. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON

public protocol APIProviderDelegate {
    func apiError(error: Error,result: APIResult)
}

public class APIProvider {
    public var delegate: APIProviderDelegate?
    public static let shared = APIProvider()
    public private(set) var sessionID = ""
    public private(set) var language = ""
    func setSession(_ session: String){
        sessionID = session
    }
    func removeSession(){
        sessionID = ""
    }
}
extension APIProvider {
        
    func loadAPI(httpMethod: HTTPMethod, urlString: String, headers: [String:String], body: [String:Any]?, noneEscaping: Bool = false) -> Observable<APIResult> {
        
        var headersTemps = headers
        var _headers: HTTPHeaders = [:]
        for key in headersTemps.keys {
            guard let value = headersTemps[key] else {continue}
            _headers[key] = value
        }
        var _body = (body?.filter { $0.value != nil } ?? [:]) as [String:Any]
        for (key, value) in _body {
            if let string = value as? String {
                if string.contains("-0400") {
                    //_body[key] = string.replace(string: "-0400", replacement: "-04:00")
                }
            }
        }
       
        let _request = !noneEscaping ?
            request(httpMethod, urlString, parameters: _body, encoding: httpMethod == .get ? URLEncoding.default :  JSONEncoding.default, headers: _headers) :
            // 不希望encoding 時字元
            request(httpMethod, urlString, parameters: _body, encoding: JSONStringArrayEncoding.default, headers: _headers)

        return _request.responseData()
            .timeout(.seconds(20), scheduler: MainScheduler.instance)
            .map { (response, data) in
            let httpResponse = response as? HTTPURLResponse
            let statusCode = String(response.statusCode)
            do {
                let jsonObj = try JSON(data: data)
                let msgCode      = jsonObj["msgCode"].stringValue
                let msgContent   = jsonObj["msgContent"].stringValue
                if msgCode == "000", msgContent == "SUCCESS" {
                    return APIResult(urlString: urlString, status: true, json: jsonObj, error: nil, statusCode: statusCode)
                }else{
                    return APIResult(urlString: urlString, status: false, json: jsonObj, error: nil, statusCode: statusCode)
                }
            } catch let error {
                let loactionURL = httpResponse?.url?.absoluteString
                var statusCode = ""
                let upupHtmlString = String(bytes: data, encoding: .utf8) ?? ""
                return APIResult(urlString: urlString, status: false, json: nil, error: nil, statusCode: statusCode)
            }
        }
    }
}
// 避免自動跳脫字元
struct JSONStringArrayEncoding: ParameterEncoding {
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest.urlRequest
        
        let data = try! JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
            let newJson = json.replacingOccurrences(of: "\\/", with: "/")
            urlRequest?.httpBody = newJson.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        }
        
        return urlRequest!
    }
    
    public static var `default`: JSONStringArrayEncoding { JSONStringArrayEncoding() }
}
