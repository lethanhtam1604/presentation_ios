//
//  UploadTextApiRequest.swift
//  Signature
//
//  Created by Thanh-Tam Le on 11/18/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

class UploadTextApiRequest: ApiRequest{
    
    override init() {
        super.init()
    }
    
    override func getRequestUrl() -> String {
        return "/api/addNewText"
    }
    
    override func getContentType() -> String {
        return "application/json"
    }
    
    override func getRequestType() -> String {
        return "POST"
    }
    
    func upload(_ uploadTextModel: UploadTextModel, completion: @escaping (_ success: Bool, _ data: AnyObject?, _ message: String?) -> ()) {
        
        let uploadText = ["id": uploadTextModel.id, "text": uploadTextModel.text, "width" : uploadTextModel.width, "height" : uploadTextModel.height, "posX" : uploadTextModel.posX, "posY" : uploadTextModel.posY, "isSent": uploadTextModel.isSent, "deleteFlag": uploadTextModel.deleteFlag] as [String : Any]
        
        request(clientURLRequest(uploadText as Dictionary<String, AnyObject>?)) { (success, object) -> () in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    completion(true, object, nil)
                } else {
                    let message = "error"
                    completion(false, nil, message)
                }
            })
        }
    }
}
