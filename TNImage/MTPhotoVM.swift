//
//  MTPhotoVM.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/7/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import Foundation

class MTPhotoVM {
    private var gallery:MTGallery = MTGallery(dict: [:])
    //public
    var needUpdate: ((_ b: Bool, _ keyCode: String?, _ msg: String?) -> ())?
    var numberofPhoto:Int {
        return gallery.items.count
    }

    public func apigetPhoto(keywork:String){
        let rq = MTRequest<MTGallery>(options: .default)
        rq.onSuccess = {res in
            self.gallery = res
            self.needUpdate?(true, nil, nil)
        }
        
        rq.onFailure = { res in
            
            let error   = "\(res.code)"
            let msg     = "\(res.message)"
            
            self.needUpdate?(true, error, msg)
        }
        ///API get Photo
        DataService.photoService.photos(keywork, request: rq)
    }
    
    public func getPreviewImage(index:Int)->String{
        let photoPreview = gallery.items[index].previewURL
        return photoPreview
    }
    
    public func getFullImage(index:Int)->String{
        let photoFull = gallery.items[index].webformatURL
        return photoFull
    }
}
