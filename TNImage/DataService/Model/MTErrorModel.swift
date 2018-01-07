//
//  DSErrorModel.swift
//  PhotoToday
//
//  Created by NS on 7/27/17.
//  Copyright © 2017 Sinhngn. All rights reserved.
//

import UIKit

enum SDErrorCode: Int {
    case unknow             = -1000
    case success            = 200
    case errorLocal         = -1
    case parseErrorLocal    = -2 // This is an error from dictionary too wrong
    case maybeInternet      = -3 // Maybe Internet is losted
}

class MTErrorModel: MTBaseModel {
    
    var message: String {
        return self.dictionary.getString(fromKey: "message")
    }
    
    var code: Int {
        return self.dictionary.getInt(forKey: "code") ?? SDErrorCode.unknow.rawValue
    }
    
    var codeEnum: SDErrorCode {
        return SDErrorCode(rawValue: self.code) ?? SDErrorCode.unknow
    }

    
    var ds_description: String {
        return self.dictionary.getString(fromKey: "description")
    }
    
    static func errorParse(addrFunc: String? = "") -> MTErrorModel {
        let code: String        = String(SDErrorCode.parseErrorLocal.rawValue)
        let message: String     = "Please, Check response from API"
        let description: String = "Error from \(String(describing: addrFunc)). You should check it."
        let model = MTErrorModel.make(code: code,
                                      message: message,
                                      description: description)
        return model
    }
    
    static func make(code: String, message: String, description: String? = "") -> MTErrorModel {
        
        var strCode = code
        
        if (code == "nil") {
            strCode = SDErrorCode.maybeInternet.rawValue.description
        }
        
        let info = [
            "code"          : strCode,
            "message"       : message,
            "description"   : description
        ]
        
        return MTErrorModel(dict: info as Dictionary<String, AnyObject>);
    }
}
