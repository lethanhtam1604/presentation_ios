//
//  MainViewController.swift
//  Signature
//
//  Created by Thanh-Tam Le on 8/30/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit
import WYPopoverController
import FontAwesomeKit
import STPopup

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate, ColorPickerDelegate, WYPopoverControllerDelegate {
    
    @IBOutlet weak var textEditorLabel: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var sizeBtn: UIButton!
    @IBOutlet weak var sizeDialog: UIView!
    @IBOutlet weak var abstractView: UIView!
    @IBOutlet weak var sliderBrush: UISlider!
    @IBOutlet weak var buttonCloseSizeDialog: UIButton!
    let gradientBackground = GradientView()
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    
    @IBOutlet weak var sendTextBtn: UIButton!
    @IBOutlet weak var sendImageBtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var emotionBtn: UIButton!
    @IBOutlet weak var mapView: UIView!
    
    var lockDraw = false
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var color = UIColor.black
    
    var popoverController: WYPopoverController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        abstractView.backgroundColor = UIColor.black
        abstractView.alpha = 0.4
        
        sizeDialog.backgroundColor = UIColor.white
        sizeDialog.layer.shadowColor = UIColor.black.cgColor
        sizeDialog.layer.shadowOpacity = 0.5
        sizeDialog.layer.shadowOffset = CGSize.zero
        sizeDialog.layer.shadowRadius = 5
        sizeDialog.layer.cornerRadius = 5
        
        mapView.backgroundColor = UIColor.white
        mapView.layer.shadowColor = UIColor.black.cgColor
        mapView.layer.shadowOpacity = 0.5
        mapView.layer.shadowOffset = CGSize.zero
        
        sliderBrush.value = Float(brushWidth)
        
        buttonCloseSizeDialog.setTitleColor(UIColor.white, for: .normal)
        buttonCloseSizeDialog.setTitleColor(Global.colorSelected, for: .highlighted)
        buttonCloseSizeDialog.insertSubview(GradientView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
            , at: 1)
        buttonCloseSizeDialog.layer.cornerRadius = 5
        buttonCloseSizeDialog.clipsToBounds = true
        
        
        let imageGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addView.addGestureRecognizer(imageGestureRecognizer)
        
        let textGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.textView.addGestureRecognizer(textGestureRecognizer)
        
        let messageIcon = FAKFontAwesome.commentsIcon(withSize: 35)
        messageIcon?.addAttribute(NSForegroundColorAttributeName, value: Global.colorMain)
        let messageImg  = messageIcon?.image(with: CGSize(width: 50, height: 50))
        sendTextBtn.setImage(messageImg, for: .normal)
        sendTextBtn.tintColor = Global.colorMain
        sendTextBtn.imageView?.contentMode = .scaleAspectFit
        sendTextBtn.layer.borderColor = Global.colorMain.cgColor
        sendTextBtn.layer.borderWidth = 2
        sendTextBtn.layer.cornerRadius = 5
        sendTextBtn.clipsToBounds = true
        
        let imageIcon = FAKFontAwesome.fileImageOIcon(withSize: 35)
        imageIcon?.addAttribute(NSForegroundColorAttributeName, value: Global.colorMain)
        let imageImg  = imageIcon?.image(with: CGSize(width: 50, height: 50))
        sendImageBtn.setImage(imageImg, for: .normal)
        sendImageBtn.tintColor = Global.colorMain
        sendImageBtn.imageView?.contentMode = .scaleAspectFit
        sendImageBtn.layer.borderColor = Global.colorMain.cgColor
        sendImageBtn.layer.borderWidth = 2
        sendImageBtn.layer.cornerRadius = 5
        sendImageBtn.clipsToBounds = true
        
        let arrowsAltIcon = FAKFontAwesome.arrowsAltIcon(withSize: 35)
        arrowsAltIcon?.addAttribute(NSForegroundColorAttributeName, value: Global.colorMain)
        let arrowsAltImg  = arrowsAltIcon?.image(with: CGSize(width: 50, height: 50))
        mapBtn.setImage(arrowsAltImg, for: .normal)
        mapBtn.tintColor = Global.colorMain
        mapBtn.imageView?.contentMode = .scaleAspectFit
        mapBtn.layer.borderColor = Global.colorMain.cgColor
        mapBtn.layer.borderWidth = 2
        mapBtn.layer.cornerRadius = 5
        mapBtn.clipsToBounds = true
        
        let smileOIcon = FAKFontAwesome.smileOIcon(withSize: 35)
        smileOIcon?.addAttribute(NSForegroundColorAttributeName, value: Global.colorMain)
        let smileOImg  = smileOIcon?.image(with: CGSize(width: 50, height: 50))
        emotionBtn.setImage(smileOImg, for: .normal)
        emotionBtn.tintColor = Global.colorMain
        emotionBtn.imageView?.contentMode = .scaleAspectFit
        emotionBtn.layer.borderColor = Global.colorMain.cgColor
        emotionBtn.layer.borderWidth = 2
        emotionBtn.layer.cornerRadius = 5
        emotionBtn.clipsToBounds = true
    }
    
    func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @IBAction func openInputTextViewDialogClick(_ sender: AnyObject) {
        
        let uploadTextViewController = UploadTextViewController(nibName: "UploadTextViewController", bundle: nil)
        //        uploadTextView.delegate = self
        
        popoverController = WYPopoverController(contentViewController: uploadTextViewController)
        popoverController?.delegate = self
        
        popoverController?.popoverContentSize = CGSize(width: 300, height: 200);
        popoverController?.presentPopoverAsDialog(animated: true)
    }
    func popoverControllerShouldDismissPopover(_ popoverController: WYPopoverController!) -> Bool {
        return true
    }
    
    func confirmFunction(value: String) {
        popoverController.dismissPopover(animated: true)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func clearSignatureClicked(_ sender: AnyObject) {
        clear()
    }
    
    func clear() {
        mainImageView.image = nil
    }
    
    @IBAction func settingClicked(_ sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        let nav = UINavigationController(rootViewController: loginViewController)
        navigationController!.present(nav, animated: true, completion: nil)
    }
    @IBAction func emotionBtnClicked(_ sender: Any) {
        let colorPickerVc = storyboard?.instantiateViewController(withIdentifier: "EmotionIconViewController") as! EmotionIconViewController
//        let popupController = STPopupController(rootViewController: colorPickerVc)
//        popupController?.style = .bottomSheet
//        popupController?.present(in: self)
        
        colorPickerVc.modalPresentationStyle = .popover
        colorPickerVc.preferredContentSize = CGSize(width: 300, height: 400)
        if let popoverController = colorPickerVc.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.emotionBtn.frame
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.any
            popoverController.delegate = self
        }
        present(colorPickerVc, animated: true, completion: nil)
    }
    
    @IBAction func mapBtnClicked(_ sender: Any) {
        if mapView.isHidden {
            mapView.isHidden = false
            lockDraw = true
        }
        else {
            mapView.isHidden = true
            lockDraw = false
        }

    }
    
    @IBAction func sendTextBtnClicked(_ sender: Any) {
        let uploadTextModel = UploadTextModel()
        uploadTextModel.id = 0
        uploadTextModel.text = textEditorLabel.text
        uploadTextModel.width = 350
        uploadTextModel.height = 250
        uploadTextModel.posX  = Int(textView.center.x)
        uploadTextModel.posY = Int(textView.center.y)
        uploadTextModel.isSent = 0
        uploadTextModel.deleteFlag = false
        
        let uploadTextApiRequest = UploadTextApiRequest()
        uploadTextApiRequest.view = self.view
        uploadTextApiRequest.upload(uploadTextModel) { (success, data, message) in
            if success == true {
                
            }
            else {
                
            }
        }
    }
    
    @IBAction func sendImageBtnClicked(_ sender: Any) {
        UIGraphicsBeginImageContext(mainImageView.bounds.size)
        
        //        let rect = CGRect(x: 0, y: 0, width: mainImageView.frame.size.width, height: mainImageView.frame.size.height)
        //        UIColor.white.setFill()
        //        UIRectFill(rect)
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0,
                                             width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData: Data = UIImagePNGRepresentation(image!)!
        let strBase64: String = imageData.base64EncodedString(options: .lineLength64Characters)
        
        var postBase64: String = ""
        postBase64 = postBase64 + strBase64
        
        let uploadImageModel = UploadImageModel()
        uploadImageModel.id = 0
        uploadImageModel.code = postBase64
        uploadImageModel.width = 350
        uploadImageModel.height = 250
        uploadImageModel.posX  = Int(addView.center.x)
        uploadImageModel.posY = Int(addView.center.y)
        uploadImageModel.isSent = 0
        uploadImageModel.deleteFlag = 0
        
        let uploadImageApiRequest = UploadImageApiRequest()
        uploadImageApiRequest.view = self.view
        uploadImageApiRequest.upload(uploadImageModel) { (success, data, message) in
            if success == true {
            
            }
            else {
                
            }
        }

    }
    
    @IBAction func sliderBrushChanged(_ sender: UISlider) {
        brushWidth = CGFloat(sender.value)
        
    }
    
    @IBAction func sizeClicked(_ sender: AnyObject) {
        abstractView.isHidden = false
        sizeDialog.isHidden = false
        lockDraw = true
    }
    
    @IBAction func closeSizeDialogClicked(_ sender: AnyObject) {
        abstractView.isHidden = true
        sizeDialog.isHidden = true
        lockDraw = false
    }
    
    @IBAction func colorClicked(_ sender: AnyObject) {
        self.showColorPicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(lockDraw == true) {
            return
        }
        
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(color.cgColor)
        //        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(lockDraw == true) {
            return
        }
        
        // 6
        swiped = true
        if let touch = touches.first  {
            let currentPoint = touch.location(in: view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(lockDraw == true) {
            return
        }
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        // show popover box for iPhone and iPad both
        return UIModalPresentationStyle.none
    }
    
    // called by color picker after color selected.
    func colorPickerDidColorSelected(selectedUIColor: UIColor, selectedHexColor: String) {
        red = selectedUIColor.coreImageColor.red
        green = selectedUIColor.coreImageColor.green
        blue = selectedUIColor.coreImageColor.blue
        color = selectedUIColor
    }
    
    
    // show color picker from UIButton
    fileprivate func showColorPicker(){
        
        // initialise color picker view controller
        let colorPickerVc = storyboard?.instantiateViewController(withIdentifier: "sbColorPicker") as! ColorPickerViewController
        
        // set modal presentation style
        colorPickerVc.modalPresentationStyle = .popover
        
        // set max. size
        colorPickerVc.preferredContentSize = CGSize(width: 265, height: 400)
        
        // set color picker deleagate to current view controller
        // must write delegate method to handle selected color
        colorPickerVc.colorPickerDelegate = self
        
        // show popover
        if let popoverController = colorPickerVc.popoverPresentationController {
            
            // set source view
            popoverController.sourceView = self.view
            
            // show popover form button
            popoverController.sourceRect = self.colorBtn.frame
            
            // show popover arrow at feasible direction
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.any
            
            // set popover delegate self
            popoverController.delegate = self
        }
        
        //show color popover
        present(colorPickerVc, animated: true, completion: nil)
    }
    
    
}
