
import Foundation
import RxSwift

extension APIProvider {
    
    /// FavoriteList
    func getFavoriteList() -> Observable<APIResult> {
        return APIProvider.shared.loadAPI(httpMethod: .get, urlString: APIInfo.getFavoriteList, headers: [:], body: [:])
    }
    

}
