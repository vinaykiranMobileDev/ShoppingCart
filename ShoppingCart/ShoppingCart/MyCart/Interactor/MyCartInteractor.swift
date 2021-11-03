//
//  MyCartInteractor.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

protocol MyCartInteractorProtocol {
    var presenter:MyCartPresenterProtocol? { get set }
    func fetchCartItems() -> [Asset]?
    func deleteAsset(_ asset: Asset)
}

class MyCartInteractor: MyCartInteractorProtocol {
    var presenter: MyCartPresenterProtocol?
    
    func fetchCartItems() -> [Asset]? {
        return CoreDataManager.shared.getAllItems()    
    }
    
    func deleteAsset(_ asset: Asset) {
        CoreDataManager.shared.deleteItem(asset: asset)
    }
}
