//
//  InventoryVC.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 02/11/21.
//

import Foundation
import UIKit

protocol ViewProtocol: class{
    func onImageDownload(state: Bool, assetId: String)
    
    func onData(data: [Asset])
    func onError(error: Error)
}

class InventoryVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var presentor:PresenterProtocol?
    
    var dataSource = [Asset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentor?.startFetchingUserData()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(moveToCart))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func moveToCart() {
        guard let aNavVC = self.navigationController else { return }
        self.presentor?.moveToCartsVC(aNavVC)
    }
}

extension InventoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryAssetCell", for: indexPath) as? InventoryAssetCell else {
            return UICollectionViewCell()
        }
        
        let asset = dataSource[indexPath.item]
        guard let aID = asset.id else { return UICollectionViewCell() }
        
        if asset.imageDownloadState == nil {
            asset.imageDownloadState = .waiting
        }
        
        if let aImageData = UtilityManager.read(fromDocumentsWithFileName: aID){
            asset.imageData = aImageData
            asset.imageDownloadState = .completed
        } else if self.shouldDownloadImage(asset) {
            asset.imageDownloadState = .inProgress
            self.presentor?.fetchImageData(urlString: asset.image ?? "", assetID: aID)
        }
        aCell.configureWithData(asset)
        
        aCell.layer.cornerRadius = 5
        aCell.layer.borderWidth = 1
        aCell.layer.borderColor = UIColor.white.cgColor
        aCell.layer.shadowColor = UIColor.lightGray.cgColor
        aCell.layer.shadowOpacity = 0.5
        aCell.layer.shadowOffset = CGSize(width: -1, height: 1)
        aCell.layer.shadowRadius = 5
        
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 200
        var height = 150
        if UIWindow.isLandscape {
            width = Int(self.view.frame.size.width/3 - 40.0)
            height = 350
        } else {
            width = Int(self.view.frame.size.width/2 - 30.0)
            let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
            
            if deviceIdiom == .pad {
                height = 350
            }
        }
        
        return CGSize(width: width,height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let aNavVC = self.navigationController else { return }
        self.presentor?.moveToDetailedViewController(navigationController: aNavVC, asset: dataSource[indexPath.item])
    }
    
    func shouldDownloadImage(_ asset: Asset) -> Bool {
        guard let aState = asset.imageDownloadState else { return false }
        
        switch aState {
        case .waiting:
            return true
        default:
            return false
        }
    }
}


extension InventoryVC : ViewProtocol {
    func onImageDownload(state: Bool, assetId: String) {
        guard let aIndex = self.dataSource.firstIndex(where: {$0.id == assetId}) else { return }
        
        
        let aAsset = dataSource[aIndex]
        
        if state {
            aAsset.imageDownloadState = .completed
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(row: aIndex, section: 0)])
            }
        } else {
            aAsset.imageDownloadState = .failed
        }
    }
    
    func onData(data: [Asset]) {
        let _ = data.map({$0.imageDownloadState = .waiting})
        
        self.dataSource.append(contentsOf: data)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onError(error: Error) {
        print(error)
    }
}

