//
//  MyCartCell.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

class MyCartCell: UITableViewCell {
    
    @IBOutlet weak var assetImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureWith(_ asset: Asset) {
        self.titleLabel.text = asset.name
        self.priceLabel.text = "$ " + (asset.price ?? "")
        
        guard let aID = asset.id else { return }
        
        if let aImageData = UtilityManager.read(fromDocumentsWithFileName: aID){
            assetImage.image = UIImage(data: aImageData)
            assetImage.layer.cornerRadius = 15
        }
    }
}
