//
//  MTImageViewController.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/1/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import UIKit
import ImageSlideshow

class MTImageViewController: UIViewController {
    @IBOutlet var imageSlideShow: ImageSlideshow!
    var photo:MTPhotoModel?
    var titleA:String?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let source = AlamofireSource(urlString: (photo?.webformatURL)!) {
            imageSlideShow.activityIndicator = DefaultActivityIndicator()
            imageSlideShow.setImageInputs([source])
            imageSlideShow.backgroundColor = UIColor.init(red: 236, green: 236, blue: 236, alpha: 0.5)
        }
    }
    @IBAction func handleClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //save local Image
    func saveImage(imgSave:UIImage){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        var imagesDirectoryPath:String!
        imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        //save Image to
        var imagePath = NSDate().description
        imagePath = imagePath.replacingOccurrences(of: " ", with: "")
        imagePath = imagesDirectoryPath.appending("/\(imagePath).png")
        print("Path \(imagePath)")
        
        let data = UIImagePNGRepresentation(imgSave)
        FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        let imageAhihi = UIImage(contentsOfFile: imagePath)
        print(imageAhihi!)
    }
    @IBAction func handleSave(_ sender: Any) {
        
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
            //let imgView = UIImageView()
//            AlamofireSource(urlString: (self?.arrTest![3])!)?.load(to: imgView) { (img) in
//                if let imageView:UIImage = img {
//                    self?.saveImage(imgSave: imageView)
//                }
//                
//            }
            DataService.coredataService.savePhoto(title: (self?.titleA!)!, previewImage: (self?.photo?.previewURL)!, fullImage: (self?.photo?.webformatURL)!)
//            DataService.coredataService.fetchAndPrintEachPerson { (arr) in
//                print(arr.count)
//                let pathCoreData:Image = arr.last!
//                print(pathCoreData.name!)
//                print(pathCoreData.urlFull!)
//                print(pathCoreData.urlPreview!)
            //}
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}
