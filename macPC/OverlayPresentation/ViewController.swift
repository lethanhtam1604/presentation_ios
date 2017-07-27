//
//  ViewController.swift
//  OverlayPresentation
//
//  Created by Thanh-Tam Le on 11/16/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import Cocoa
//import Alamofire

class ViewController: NSViewController {
    
    var imgView: NSImageView!
    @IBOutlet weak var textLabel: NSTextField!
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var menuBarHeight: CGFloat!
    var posX: CGFloat = 0
    var posY: CGFloat
        = 0
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        screenWidth = NSScreen.main()?.frame.size.width
        screenHeight = NSScreen.main()?.frame.size.height

        if let screen = NSScreen.main() {
            self.view.window?.setFrame(screen.visibleFrame, display: true, animate: true)
        }
        
        self.view.window?.isExcludedFromWindowsMenu = false
        self.view.window?.ignoresMouseEvents = true
        self.view.window?.isOpaque = false
        self.view.window?.level = Int(CGWindowLevelForKey(.overlayWindow))
        self.view.window?.titleVisibility = .hidden
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.clear
        self.view.window?.hasShadow = false
        
        self.view.window?.standardWindowButton(NSWindowButton.closeButton)!.isHidden = true
        self.view.window?.standardWindowButton(NSWindowButton.miniaturizeButton)!.isHidden = true
        self.view.window?.standardWindowButton(NSWindowButton.zoomButton)!.isHidden = true

        posX = screenWidth / 2
        posY = screenHeight / 2

            
        textLabel.frame = NSRect(x: posX - 150, y: posY - 150, width: 300, height: 300)
        imgView = NSImageView(frame:NSRect(x: posX - 150, y: posY - 150, width: 300, height: 300))
//        imgView.image = NSImage(named:"my_profile")
        
        self.view.addSubview(imgView)

    }

    var textsResult: [TextModel] = []
    var imagesResult: [ImageModel] = []

    var currentTextIndex = 0
    var currentImageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        getTextApiRequest()
        getImageApiRequest()

        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(goToConfirmEmployee), userInfo: nil, repeats: true)
    }

    func goToConfirmEmployee() {
        getTextApiRequest()
        getImageApiRequest()
    }
    
    private func getTextApiRequest() {
        let getTextApiRequest = GetTextApiRequest()
        getTextApiRequest.getTextApiRequest() { (success, data, message) in
            if success == true {
                for item in data as! [TextModel] {
                    self.textsResult.append(item)
                }
                self.showText()
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.showText), userInfo: nil, repeats: true)
            }
            else {
                
            }
        }
    }
    
    private func getImageApiRequest() {
        let getImageApiRequest = GetImageApiRequest()
        getImageApiRequest.getImageApiRequest() { (success, data, message) in
            if success == true {
                for item in data as! [ImageModel] {
                    self.imagesResult.append(item)
                }
                self.showImage()
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.showImage), userInfo: nil, repeats: true)
            }
            else {
                
            }
        }
    }
    
    func showText() {
        if currentTextIndex < self.textsResult.count {
            let textModel = self.textsResult[currentTextIndex]
            self.textLabel.stringValue = textModel.text
            
            let textHeight = textModel.text.heightWithConstrainedWidth(width: 300, font: textLabel.font!)
            
            let ratioX = screenWidth / CGFloat(textModel.width)
            let ratioY = screenHeight / CGFloat(textModel.height)
            
            let x = ratioX * CGFloat(textModel.posX)
            let y = ratioY * CGFloat(textModel.posY)

            textLabel.frame = NSRect(x: x - 150, y: screenHeight - y - 150 - (300 - textHeight)/2, width: 300, height: 300)
            currentTextIndex = currentTextIndex + 1
        }
    }
    
    func showImage() {
        if currentImageIndex < self.imagesResult.count {
            
            let imageModel = self.imagesResult[currentImageIndex]
            let base64 = imageModel.code
            let imageData = NSData(base64Encoded: base64!, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            let image = NSImage(data: imageData as! Data)
            
            imgView.image = image
            
            
            let ratioX = screenWidth / CGFloat(imageModel.width)
            let ratioY = screenHeight / CGFloat(imageModel.height)
            
            let x = ratioX * CGFloat(imageModel.posX)
            let y = ratioY * CGFloat(imageModel.posY)
            
            imgView.frame = NSRect(x: x - 150, y: screenHeight - y - 150, width: 300, height: 300)
            
            currentImageIndex = currentImageIndex + 1

        }
    }
}

