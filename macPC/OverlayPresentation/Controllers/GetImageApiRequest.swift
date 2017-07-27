//
//  GetImageApiRequest.swift
//  OverlayPresentation
//
//  Created by Thanh-Tam Le on 11/21/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import Cocoa

class GetImageApiRequest: ApiRequest{
    
    override init() {
        super.init()
    }
    
    override func getRequestUrl() -> String {
        return "/api/getNewImage"
    }
    
    override func getContentType() -> String {
        return "application/json"
    }
    
    override func getRequestType() -> String {
        return "GET"
    }
    
    func getImageApiRequest(completion: @escaping (_ success: Bool, _ data: AnyObject?, _ message: String?) -> ()) {
        
        request(request: clientURLRequest(params: nil)) { (success, object) -> () in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    let imageModel = ImageModel()
                    var results: [ImageModel] = []
                    if let items = object as? NSArray {
                        for itemDict in items as! [NSDictionary] {
                            imageModel.id = (itemDict.value(forKey: "id") as? Int)!
                            imageModel.code = (itemDict.value(forKey: "code") as? String)!
                            imageModel.width = (itemDict.value(forKey: "width") as? Int)!
                            imageModel.height = (itemDict.value(forKey: "height") as? Int)!
                            imageModel.posX = (itemDict.value(forKey: "posX") as? Int)!
                            imageModel.posY = (itemDict.value(forKey: "posY") as? Int)!
                            results.append(imageModel)
                        }
                        completion(true, results as AnyObject?, nil)
                    }
                    
                } else {
                    let message = "error"
                    completion(false, nil, message)
                }
            })
        }
    }
}
