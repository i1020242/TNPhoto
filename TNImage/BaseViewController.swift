//
//  BaseViewController.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/7/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "No Internet connection", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicator(viewA:UIView) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        viewA.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
