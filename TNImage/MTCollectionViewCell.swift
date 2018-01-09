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
    let imagePhoto = UIImageView()
    func configure(_ url:String) {
        
        ///image
        prepareForReuse()
        imagePhoto.contentMode = .scaleToFill
        addSubview(imagePhoto)
        imagePhoto.mas_makeConstraints({ (make) in
            make?.top.equalTo()(mas_top)?.with().offset()(0)
            make?.left.equalTo()(mas_left)?.with().offset()(0)
            make?.right.equalTo()(mas_right)?.with().offset()(0)
            make?.bottom.equalTo()(mas_bottom)?.with().offset()(0)
            return()
        })
        if Connection.isInternetAvailable(){
            showActivityIndicator()
            Alamofire.request(url).responseImage { [weak self] response in
                self?.stopActivityIndicator()
                if let image = response.result.value {
                    self?.imagePhoto.image = image
                }
            }
        } else {
            do {
                let fileURL = URL(fileURLWithPath: url)
                let imageData = try Data(contentsOf: fileURL)
                imagePhoto.image = UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePhoto.image = nil
    }
}
