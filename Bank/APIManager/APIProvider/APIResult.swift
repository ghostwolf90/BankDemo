import UIKit
import SwiftyJSON

public struct APIResult {
    public let urlString: String
    public var status: Bool
    public let json: JSON?
    public let error: Error?
    public let statusCode: String
    
    public init(urlString: String ,status: Bool, json: JSON?, error: Error?, statusCode: String) {
        self.urlString = urlString
        self.status = status
        self.json = json
        self.error = error
        self.statusCode = statusCode
    }
}
