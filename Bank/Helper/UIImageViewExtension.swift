//
//  UIImageViewExtension.swift
//  Bank
//
//  Created by 仲立 on 2023/7/31.
//  Copyright © 2023 仲立. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    public static func loadUrlImage(urlString: String, cacheKey: String ,callBack:@escaping (String, String, UIImage?)->Void){
        guard let imageType = urlString.components(separatedBy: ".").last?.lowercased() else { return }
        var imageURLString = urlString
        if !urlString.contains("https://") && !urlString.contains("http://"){
            imageURLString = "https://" + urlString
        }
        guard let url = URL(string: imageURLString) else {
            NSLog("圖片URL錯誤:\(urlString)")
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: cacheKey != "" ? cacheKey : urlString)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let value):
                        callBack(imageType, cacheKey, value.image)
                    case .failure(let error):
                        _ = error
                        print("圖片response錯誤 url: \(urlString)")
                        callBack(imageType, cacheKey, nil)
                    }
                }
    }
}
