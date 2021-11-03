//
//  InventoryModels.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 02/11/21.
//

import Foundation

enum ImageDownloadState:String, Codable {
    case inProgress, waiting, failed, completed
}

class Asset: Codable {
    var id: String?
    var name: String?
    var image: String?
    var description: String?
    var price: String?
    var imageData: Data?
    var imageDownloadState: ImageDownloadState? = .waiting
    
    init(id: String, name: String, image: String, description: String,price: String) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.price = price
    }
}
