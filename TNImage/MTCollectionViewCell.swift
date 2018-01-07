//
//  MTCollectionViewCell.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 12/31/17.
//  Copyright © 2017 Nguyễn Minh Trí. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MTCollectionViewCell: UICollectionViewCell {
    
    func configure(_ url:String) {
        showActivityIndicator()
        ///image
        let imagePhoto = UIImageView()
        imagePhoto.contentMode = .scaleToFill
        addSubview(imagePhoto)
        imagePhoto.mas_makeConstraints({ (make) in
            make?.top.equalTo()(mas_top)?.with().offset()(0)
            make?.left.equalTo()(mas_left)?.with().offset()(0)
            make?.right.equalTo()(mas_right)?.with().offset()(0)
            make?.bottom.equalTo()(mas_bottom)?.with().offset()(0)
            return()
        })
        
        Alamofire.request(url).responseImage { [weak self] response in
            self?.stopActivityIndicator()
            if let image = response.result.value {
                imagePhoto.image = image
            }
        }
    }
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicator() {
        activityIndicator.center = center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
