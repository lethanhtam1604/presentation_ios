//
//  EmotionIconManager.swift
//  Signature
//
//  Created by Thanh-Tam Le on 11/25/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

class EmotionIconManager {

    private static var sharedInstance: EmotionIconManager!

    var emotionIconList = [EmotionIconModel]()

    
    static func getInstance() -> EmotionIconManager {
        if(sharedInstance == nil) {
            sharedInstance = EmotionIconManager()
        }
        return sharedInstance
    }
    
    private init() {
        createDatas()
    }
    
    private func createDatas() {
        var emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)

        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
        
        emotionIconModel = EmotionIconModel()
        emotionIconModel.emotionIcon = "ic_home"
        emotionIconList.append(emotionIconModel)
    }
}
