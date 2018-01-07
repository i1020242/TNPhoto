//
//  MTPhotoModel.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/6/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit

class MTGallery: MTBaseModel {
    
    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
        self.items = self.parse_item(dicts: dict.getArray(fromKey: "hits"))
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var items: [MTPhotoModel] = []
    
    func parse_item(dicts: [Dictionary<String, AnyObject>]) -> [MTPhotoModel] {
        
        var output: [MTPhotoModel] = []
        
        for item in dicts {
            let photo = MTPhotoModel(dict: item)
            output.append(photo)
        }
        
        self.dictionary["item"] = nil
        
        return output
    }
}

class MTPhotoModel: MTBaseModel {
    override init(dict: Dictionary<String, AnyObject>) {
        super.init(dict: dict)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var previewURL:String {
        let result = self.dictionary.getString(fromKey: "previewURL")
        return result
    }
    
    var webformatURL:String {
        let result = self.dictionary.getString(fromKey: "webformatURL")
        return result
    }
    
}
