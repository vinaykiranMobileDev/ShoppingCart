//
//  DetailedViewPresenter.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

protocol DetailedViewPresenterProtocol {
    var view: DetailedViewProtocol? {get set}
    var interactor: DetailedViewInteractorProtocol? {get set}
    var router: DetailedViewRouterProtocol? {get set}
    func isAssetAddedToCart(_ asset: Asset) -> Bool
    func addToCart(asset: Asset)
    func removeformCart(asset: Asset)
    func moveToMyCart(navigationVC: UINavigationController)
}

class DetailedViewPresenter:DetailedViewPresenterProtocol {
    var view: DetailedViewProtocol?
    
    var interactor: DetailedViewInteractorProtocol?
    
    var router: DetailedViewRouterProtocol?
    
    func isAssetAddedToCart(_ asset: Asset) -> Bool {
        return self.interactor?.isAssetAddedToCart(asset) ?? false
    }
    
    func addToCart(asset: Asset) {
        self.interactor?.addToCart(asset: asset)
    }
    
    func removeformCart(asset: Asset) {
        self.interactor?.removeformCart(asset: asset)
    }
    
    func moveToMyCart(navigationVC: UINavigationController) {
        self.router?.moveToMyCart(navigationVC: navigationVC)
    }
}
