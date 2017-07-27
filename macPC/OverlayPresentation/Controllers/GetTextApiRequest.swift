//
//  GetTextApiRequest.swift
//  OverlayPresentation
//
//  Created by Thanh-Tam Le on 11/18/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import Cocoa

class GetTextApiRequest: ApiRequest{
    
    override init() {
        super.init()
    }
    
    override func getRequestUrl() -> String {
        return "/api/getNewText"
    }
    
    override func getContentType() -> String {
        return "application/json"
    }
    
    override func getRequestType() -> String {
        return "GET"
    }
    
    func getTextApiRequest(completion: @escaping (_ success: Bool, _ data: AnyObject?, _ message: String?) -> ()) {
        
        request(request: clientURLRequest(params: nil)) { (success, object) -> () in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    let textModel = TextModel()
                    var results: [TextModel] = []
                    if let items = object as? NSArray {
                        for itemDict in items as! [NSDictionary] {
                            textModel.id = (itemDict.value(forKey: "id") as? Int)!
                            textModel.text = (itemDict.value(forKey: "text") as? String)!
                            textModel.width = (itemDict.value(forKey: "width") as? Int)!
                            textModel.height = (itemDict.value(forKey: "height") as? Int)!
                            textModel.posX = (itemDict.value(forKey: "posX") as? Int)!
                            textModel.posY = (itemDict.value(forKey: "posY") as? Int)!
                            results.append(textModel)
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
