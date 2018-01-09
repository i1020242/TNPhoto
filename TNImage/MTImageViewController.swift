//
//  MTImageViewController.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/1/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit
import CoreData

class MTImageViewController: UIViewController {
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var photo:MTPhotoModel?
    var photo_core:Image?
    var titleA:String?
    var vm:MTPhotoVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit
        if Connection.isInternetAvailable() {
            ImageLoader.sharedLoader.imageForUrl(urlString: (photo?.webformatURL)!) { (imageTest, str) in
                self.imageView.image = imageTest
            }
            btnSave.isHidden = false
        } else {
            if let image = photo_core?.urlFull {
                self.imageView.image = UIImage(contentsOfFile: image)
            }
            ///btn
            //btnSave.isHidden = true
        }
        
        
    }
    
    @IBAction func handleClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //save local Image
    func saveImage(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        /// Get the Document directory path
        let documentDirectorPath:String = paths[0]
        /// Create a new path for the new images folder
        var imagesDirectoryPath:String!
        imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        /// If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        
        let currentDay = getCurrentDay()
        let currentDayA = currentDay.replacingOccurrences(of: " ", with: "")
        let imagePathFull = imagesDirectoryPath.appending("/\(currentDayA).png")
        let imagePathPreview = imagesDirectoryPath.appending("/\(currentDayA)_P.png")
        print(imagePathPreview)
        if let imageView = self.imageView.image{
            let imageData = UIImagePNGRepresentation(imageView)
            print(imageData!)
            FileManager.default.createFile(atPath: imagePathFull, contents: imageData, attributes: nil)
            FileManager.default.createFile(atPath: imagePathPreview, contents: imageData, attributes: nil)
            DataService.coredataService.savePhoto(title: (self.titleA!), previewImage: imagePathPreview, fullImage: imagePathFull)
        }
        
    }
    @IBAction func handleSave(_ sender: Any) {
        if Connection.isInternetAvailable(){
            let alert = UIAlertController(title: "Save", message: "Do you save fucking image?", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = self.titleA
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
                self?.saveImage()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            ///handle delete
            vm?.deletePhoto(photo: photo_core!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func getCurrentDay() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
}

class ImageLoader {
    
    let cache = NSCache<NSString, AnyObject>()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler: @escaping (_ image: UIImage?, _ url: String) -> ()) {
        
        DispatchQueue.global(qos: .background).async {
            
            let data: NSData? = self.cache.object(forKey: urlString as NSString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
            
            let session = URLSession.shared
            let request = URLRequest(url: URL(string: urlString)!);
            
            session.dataTask(with: request) { data, response, error in
                
                if (error != nil) {
                    completionHandler(nil, urlString)
                    return
                }
                
                if let data = data{
                    let image = UIImage(data: data)
                    self.cache.setObject(data as AnyObject, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                }
                }.resume()
            
        }
    }
}
