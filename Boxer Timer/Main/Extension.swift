//
//  Extension.swift
//  Boxer Timer
//
//  Created by Марат Нургалиев on 04.06.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Foundation




//struct GlobalConstants {
//
//    static let isDebugWork = true
//
//    static var mainAPI: String   = "https://api.unipark.kz/"
//    static var APIver: String    = "v1/"
//    static var photoURL: String  = ""
//    static var user:User         = User()
//    static var cityArray: [JSON] = []
//    static var PUSHToken:String  = ""
//
//    static var needFastStart:Bool = false
//    static var driverSelectedTab:UInt = 0
//    static var header:HTTPHeaders = [:]
//
//    static var webView:WKWebView = WKWebView()
//}

//struct defaultsKeys {
//    static let authToken     = "UniParkAuthToken"
//    static let userId        = "UniParkuserID"
//    static let appType       = "UniParkAppType"
//    static let GoogleMapsKey = "AIzaSyB-Q4drkXQlrZPeUCLlIcXnOBk14pBolM4"
//}
//
//class User {
//
//    var id: Int                     = -1
//    var phone_number: String        = ""
//    var password:String             = ""//Delete before AppStore
//    var email: String               = ""
//    var firstname: String           = ""
//    var lastname: String            = ""
//    var birth_date: Date!
//    var gender: String              = ""
//    var is_driver: Bool             = false
//    var has_special_service: String = ""
//    var status: String              = ""
//    var access_token: String        = ""
//    var phone_token: String         = ""
//    var phone_type: String          = ""
//    var created_at: String          = ""
//    var avatar_url: String          = ""
//    var phones: [JSON]              = []
//    var city_id: String             = ""
//    var city_name: String           = ""
//    var udPhoto:String              = ""
//    var driverLicensePhoto:String   = ""
//    var id_company:String            = ""
//    var company:String            = ""
//
//
//    func loadUser(data: [String: JSON]) -> Bool {
//
//        let dateFormatter        = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.timeZone   = TimeZone.init(secondsFromGMT: 0)
//
//        id                       = (data["id"]?.intValue)!
//        phone_number             = (data["phone_number"]?.stringValue)!
//        email                    = (data["email"]?.stringValue)!
//        firstname                = (data["firstname"]?.stringValue)!
//        lastname                 = (data["lastname"]?.stringValue)!
//
//        if !data["birth_date"]!.stringValue.isEmpty {
//            birth_date           = dateFormatter.date(from: (data["birth_date"]?.stringValue)!)!
//        }
//
//        gender                   = (data["gender"]?.stringValue)!
//
//        if data["is_driver"]?.intValue == 1 {
//            is_driver            = true
//        } else {
//            is_driver            = false
//        }
//
//        has_special_service = (data["has_special_service"]?.stringValue)!
//        status              = (data["status"]?.stringValue)!
//        access_token        = (data["access_token"]?.stringValue)!
//        GlobalConstants.header = ["Authorization": "Bearer \(access_token)"]
//        phone_token         = (data["phone_token"]?.stringValue)!
//        phone_type          = (data["phone_type"]?.stringValue)!
//        created_at          = (data["created_at"]?.stringValue)!
//        avatar_url          = (data["avatar_url"]?.stringValue)!
//        city_id             = (data["city_id"]?.stringValue)!
//        city_name           = (data["city_name"]?.stringValue)!
//        udPhoto             = (data["udPhoto"]?.stringValue)!
//        driverLicensePhoto  = (data["driverLicensePhoto"]?.stringValue)!
//        phones              = (data["phone_number_additional"]?.arrayValue)!
//        company             = (data["company"]?.stringValue)!
//
//        return true
//    }
//}
//


extension UILabel {
    
    func boldRange(_ range: Range<String.Index>) {
        if let text = self.attributedText {
            let attr = NSMutableAttributedString(attributedString: text)
            let start = text.string.distance(from: text.string.startIndex, to: range.lowerBound)
            let length = text.string.distance(from: range.lowerBound, to: range.upperBound)
            attr.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: self.font.pointSize)], range: NSMakeRange(start, length))
            self.attributedText = attr
        }
    }
    
    func boldSubstring(_ substr: String) {
        let range = self.text?.range(of:substr)
        if let r = range {
            boldRange(r)
        }
    }
    
    func italicRange(_ range: Range<String.Index>) {
        if let text = self.attributedText {
            let attr = NSMutableAttributedString(attributedString: text)
            let start = text.string.distance(from: text.string.startIndex, to: range.lowerBound)
            let length = text.string.distance(from: range.lowerBound, to: range.upperBound)
            attr.addAttributes([NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: self.font.pointSize)], range: NSMakeRange(start, length))
            self.attributedText = attr
        }
    }
    
    func italicSubstring(_ substr: String) {
        let range = self.text?.range(of:substr)
        if let r = range {
            italicRange(r)
        }
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
}

extension NSMutableAttributedString {
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        }
    }
}

@IBDesignable extension UIView {
    
    /* The color of the shadow. Defaults to opaque black. Colors created
     * from patterns are currently NOT supported. Animatable. */
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            return nil
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UIImage {
    
    func fixOrientation() -> UIImage {
        
        // No-op if the orientation is already correct
        if ( self.imageOrientation == UIImageOrientation.up ) {
            return self;
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if ( self.imageOrientation == UIImageOrientation.down || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImageOrientation.left || self.imageOrientation == UIImageOrientation.leftMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }
        
        if ( self.imageOrientation == UIImageOrientation.right || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0));
        }
        
        if ( self.imageOrientation == UIImageOrientation.upMirrored || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if ( self.imageOrientation == UIImageOrientation.leftMirrored || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;
        
        ctx.concatenate(transform)
        
        if ( self.imageOrientation == UIImageOrientation.left ||
            self.imageOrientation == UIImageOrientation.leftMirrored ||
            self.imageOrientation == UIImageOrientation.right ||
            self.imageOrientation == UIImageOrientation.rightMirrored ) {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        } else {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context and return it
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
}


