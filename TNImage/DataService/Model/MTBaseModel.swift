//
//  BaseModel.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/6/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit

class MTBaseModel: NSObject {
    var dictionary : Dictionary<String, AnyObject>
    
    init(dict: Dictionary<String, AnyObject>) {
        self.dictionary = dict
    }
    
    /// Encode Object to Archive
    func encodeWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(self.dictionary, forKey:"ModelDictionary")
    }
    
    /// Decode Object when Unarchive
    required init(coder aDecoder: NSCoder) {
        let dict = aDecoder.decodeObject(forKey: "ModelDictionary") as? Dictionary<String, AnyObject>
        self.dictionary = dict ?? [:];
    }
    
    func isExist() -> Bool {
        return self.dictionary.isEmpty
    }
    
    /// check dictionnary
    func safeDictionary(_ dict: AnyObject?) -> Dictionary<String, AnyObject> {
        if dict == nil {
            return [:]
        }
        
        let result = dict as? Dictionary <String, AnyObject>
        
        if result != nil {
            return result!
        }
        
        return [:]
    }
    
    /// Print dictionary of Object
    func printMe() {
        print(self.dictionary.description);
    }
}
