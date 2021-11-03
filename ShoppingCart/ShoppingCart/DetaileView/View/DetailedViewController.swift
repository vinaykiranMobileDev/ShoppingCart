//
//  DetailedViewController.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

protocol DetailedViewProtocol {
    func upatedSavedState()
}

class DetailedViewController: UIViewController {
    var presentor: DetailedViewPresenterProtocol?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var assetImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var asset: Asset?
    
    func isAddedToCart() -> Bool  {
        
        guard let aAsset = asset else { return false }
        
        return self.presentor?.isAssetAddedToCart(aAsset) ?? false
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        guard let aAsset = asset else { return }
        if isAddedToCart() {
            self.presentor?.removeformCart(asset: aAsset)
        } else {
            self.presentor?.addToCart(asset: aAsset)
        }
        
        self.updateButtonTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.asset?.name ?? ""
        self.priceLabel.text =  "$ " + (self.asset?.price ?? "")
        self.descriptionLabel.text = self.asset?.description ?? ""
        
        if let aData = self.asset?.imageData {
            self.assetImage.image = UIImage(data: aData)
            self.assetImage.layer.cornerRadius = 15
        }
        
        self.addToCartButton.layer.cornerRadius = 10
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(moveToCart))
        self.updateButtonTitle()
    }
    
    func updateButtonTitle() {
        DispatchQueue.main.async {
            self.addToCartButton?.setTitle(self.getButtonTitle(), for: .normal)
        }
    }
    
    func getButtonTitle() -> String {
        return self.isAddedToCart() ? "Remove From Cart" : "Add To Cart"
    }
    
    @objc func moveToCart() {
        guard let aNavVC = self.navigationController else { return }
        self.presentor?.moveToMyCart(navigationVC: aNavVC)
    }
}

extension DetailedViewController: DetailedViewProtocol {
    func upatedSavedState() {
     //To do
    }
}
