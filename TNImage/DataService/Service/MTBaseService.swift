//
//  BaseService.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/6/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit

enum DSRequestEnum {
    case `default`
    case network
    case cached
}

class MTRequest <Out>: NSObject {
    
    fileprivate var aOption: DSRequestEnum;
    init(options: DSRequestEnum) {
        aOption = options
    }
    
    var onSuccess:((_ result: Out)->())?
    var onFailure:((_ error: MTErrorModel)->())?
    var  onUpdate:((_ result: Out)->())?
}

class MTBaseService: NSObject {
    /// Http request
    let httpUtillty: HttpUtility = HttpUtility();
}
