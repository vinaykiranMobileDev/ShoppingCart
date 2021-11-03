//
//  DetailedViewInteractor.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation

protocol DetailedViewInteractorProtocol {
    var presenter:DetailedViewPresenterProtocol? {get set}
    func isAssetAddedToCart(_ asset: Asset) -> Bool
    func addToCart(asset: Asset)
    func removeformCart(asset: Asset)
}

class DetailedViewInteractor:DetailedViewInteractorProtocol {
    var presenter: DetailedViewPresenterProtocol?
    
    func isAssetAddedToCart(_ asset: Asset) -> Bool {
        if let _ = CoreDataManager.shared.getDataFor(asset) {
            return true
        } else {
            return false
        }
    }
    
    func addToCart(asset: Asset) {
        CoreDataManager.shared.addItem(asset)
    }
    
    func removeformCart(asset: Asset) {
        CoreDataManager.shared.deleteItem(asset: asset)
    }
    
    
}
