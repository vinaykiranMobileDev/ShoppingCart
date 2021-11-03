//
//  InventoryAssetCell.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

class InventoryAssetCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var model: Asset?
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    func configureWithData(_ data : Asset) {
        self.model = data
        self.titleLabel.text = model?.name ?? ""
        self.priceLabel.text = "$ " + (model?.price ?? "")
        self.imageView.image = nil
        
        if let aData = self.model?.imageData, let aImage = UIImage(data: aData) {
            DispatchQueue.main.async {
                self.imageView.image = aImage
            }
        }
    }
}
