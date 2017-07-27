//
//  UploadImageApiRequest.swift
//  Signature
//
//  Created by Thanh-Tam Le on 9/8/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

class UploadImageApiRequest: ApiRequest{
    
    override init() {
        super.init()
    }
    
    override func getRequestUrl() -> String {
        return "/api/addNewImage"
    }
    
    override func getContentType() -> String {
        return "application/json"
    }
    
    override func getRequestType() -> String {
        return "POST"
    }
    

    func upload(_ uploadImageModel: UploadImageModel, completion: @escaping (_ success: Bool, _ data: AnyObject?, _ message: String?) -> ()) {
        
        let uploadImage = ["id": uploadImageModel.id, "code": uploadImageModel.code, "width" : uploadImageModel.width, "height" : uploadImageModel.height, "posX" : uploadImageModel.posX, "posY" : uploadImageModel.posY, "isSent": uploadImageModel.isSent, "deleteFlag": uploadImageModel.deleteFlag] as [String : Any]

        request(clientURLRequest(uploadImage as Dictionary<String, AnyObject>?)) { (success, object) -> () in
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
