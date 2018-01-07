//
//  MTPhotoService.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/6/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit

class MTPhotoService: MTBaseService {
    func photos(_ keywork: String, request: MTRequest<MTGallery>) {
        let url = "https://pixabay.com/api/?key=7516877-d2eff1f33d00df880debea06c&q=\(keywork)"
        var rq  = Request(.get, url)
        
        rq.onSuccess = { result in
            if let dict = result as? Dictionary<String, AnyObject> {
                let photoGallery = MTGallery(dict: dict)
                request.onSuccess?(photoGallery)
            } else {
                request.onFailure?(MTErrorModel.errorParse(addrFunc: "\(self).photos"))
            }
        }
        
        rq.onFailure = { error in
            request.onFailure?(error)
        }
        
        httpUtillty.request(rq: rq)
    }
}
