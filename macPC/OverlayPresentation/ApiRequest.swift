//
//  ApiRequest.swift
//  Demo
//
//  Created by Tam Huynh on 7/10/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import Cocoa

class ApiRequest {
    
    private let API_HOST = "http://192.168.0.104:9000"
    private var token: String!
    
    func getLoadingMessage () -> String { return ""}
    func getRequestUrl () -> String { return ""}
    func getContentType () -> String { return ""}
    func getRequestType () -> String { return ""}
    func resultReceiver (response: String) -> AnyObject? { return nil}
    func isOpenProgressBar () -> Bool {return false}
    func setToken(token: String) {}
    
    func getFullRequestLink() -> String {
        return API_HOST + getRequestUrl()
    }
    
    private func dataTask(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = getRequestType()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
                
                DispatchQueue.main.async {
//                    Utils.hideHub(view: Global.view)
                }
            }
            }.resume()
    }
    
    func request(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, completion: completion)
    }
    
    func clientURLRequest(params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
//        Utils.showHub(view: Global.view)
        let request = NSMutableURLRequest(url: NSURL(string: getFullRequestLink())! as URL)
        if let params = params {
            
            let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
            
            request.addValue(getContentType(),forHTTPHeaderField: "Content-Type")
            request.addValue(getContentType(),forHTTPHeaderField: "Accept")
            request.httpBody = data
        }
        
        if let token = token {
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
