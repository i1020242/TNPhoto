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
    var needUpdateDelete: ((_ b: Bool, _ keyCode: String?, _ msg: String?) -> ())?
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
    
    func deletePhoto(photo:Image) {
        DataService.coredataService.deletePhoto(photo: photo) {
            self.needUpdateDelete?(true, nil, nil)
        }
    }
    
    public func getPreviewPhotoURL(index:Int)->String{
        let photoPreview = gallery.items[index].previewURL
        return photoPreview
    }
    
    public func getFullPhotoURL(index:Int)->String{
        let photoFull = gallery.items[index].webformatURL
        return photoFull
    }
    
    public func getPhoto(index:Int)->MTPhotoModel{
        let photoFull = gallery.items[index]
        return photoFull
    }
    ///CoreData
    private var coPhoto:[Image]?
    public func coreDataGetPhoto(keywork:String){
        DataService.coredataService.fetchAndPrintEachPerson(keywork: keywork) { (results) in
            self.needUpdate?(true, nil, nil)
            coPhoto = results
        }
        self.needUpdate?(true, nil, nil)
    }
    func conumber()->Int{
        if coPhoto != nil {
            return (coPhoto?.count)!
        }
        return 0
    }
    
    public func getPreviewPhotoURL_co(index:Int)->String{
        let photoPreview = coPhoto![index].urlPreview
        return photoPreview!
    }
    
    public func getFullPhotoURL_co(index:Int)->String{
        let photoPreview = coPhoto![index].urlFull
        return photoPreview!
    }
    public func getPhoto_co(index:Int)->Image{
        let photoFull = coPhoto![index]
        return photoFull
    }
}
