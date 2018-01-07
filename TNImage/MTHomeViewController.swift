//
//  ViewController.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 12/26/17.
//  Copyright © 2017 Nguyễn Minh Trí. All rights reserved.
//

import UIKit
import Alamofire
import Masonry

class MTHomeViewController: BaseViewController {
    @IBOutlet weak var barSearch: UISearchBar!
    @IBOutlet weak var colView: UICollectionView!
    ///VM
    var vm:MTPhotoVM = MTPhotoVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        vm.needUpdate = { (bool,a,b) in
            self.colView.reloadData()
        }
    }
    
    func setupCollectionView() {
        colView.register(MTCollectionViewCell.self, forCellWithReuseIdentifier: "Ahihi")
        colView.delegate = self
        colView.dataSource = self
        colView.collectionViewLayout = UICollectionViewFlowLayout()
        //seerchBar UI
        barSearch.searchBarStyle = .minimal
        barSearch.placeholder = "Keywork"
        barSearch.mas_makeConstraints({ (make:MASConstraintMaker?) in
            make?.top.equalTo()(view.mas_top)?.with().offset()(20)
            make?.left.equalTo()(view.mas_left)?.with().offset()(0)
            make?.right.equalTo()(view.mas_right)?.with().offset()(0)
            make?.height.mas_equalTo()(56)
            return()
        })
        //collectionView UI
        colView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(barSearch.mas_bottom)?.with().offset()(10)
            make?.left.equalTo()(view.mas_left)?.with().offset()(0)
            make?.right.equalTo()(view.mas_right)?.with().offset()(0)
            make?.bottom.equalTo()(view.mas_bottom)?.with().offset()(0)
            return()
        }
        barSearch.delegate = self
    }
}

extension MTHomeViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if Connection.isInternetAvailable() {
            vm.apigetPhoto(keywork: searchBar.text!)
        } else {
            showAlert()
        }
    }
}

extension MTHomeViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberofPhoto
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = colView?.dequeueReusableCell(withReuseIdentifier: "Ahihi", for: indexPath) as? MTCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(vm.getPreviewImage(index: indexPath.row))
        return cell
    }
}

extension MTHomeViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let imageVC = storyBoard.instantiateViewController(withIdentifier: "MTImageViewController") as? MTImageViewController
        imageVC?.fullImage = vm.getFullImage(index: indexPath.row)
        present(imageVC!, animated: true, completion: nil)
    }
}

extension MTHomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenSize.SCREEN_WIDTH/3) - 5, height: (ScreenSize.SCREEN_WIDTH/3) - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}

