//
//  MyCartPresenter.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation

protocol MyCartPresenterProtocol {
    var view: MyCartViewProtocol? {get set}
    var interactor: MyCartInteractorProtocol? {get set}
    var router: MyCartRouterProtocol? {get set}
    
    func fetchCartItems() -> [Asset]
    func deleteAsset(_ asset: Asset)
}

class MyCartPresenter: MyCartPresenterProtocol {
    var view: MyCartViewProtocol?
    
    var interactor: MyCartInteractorProtocol?
    
    var router: MyCartRouterProtocol?
    
    func fetchCartItems() -> [Asset] {
        return self.interactor?.fetchCartItems() ?? []
    }
    
    func deleteAsset(_ asset: Asset) {
        self.interactor?.deleteAsset(asset)
    }
}
