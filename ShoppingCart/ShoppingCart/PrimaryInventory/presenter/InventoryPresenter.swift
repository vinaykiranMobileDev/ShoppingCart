//
//  InventoryPresenter.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 02/11/21.
//

import Foundation
import UIKit

protocol PresenterProtocol: class{
    
    var view: ViewProtocol? {get set}
    var interactor: InteractorProtocol? {get set}
    var router: RouterProtocol? {get set}
    func startFetchingUserData()
    func fetchImageData(urlString: String, assetID: String)
    func moveToDetailedViewController(navigationController:UINavigationController, asset: Asset)
    func moveToCartsVC(_ navigationController:UINavigationController)
    func onData(result: [Asset])
    func onError(error: Error)
    func onImageDownload(state: Bool, assetId: String)

}

class InventoryPresenter: PresenterProtocol {
    var view: ViewProtocol?
    
    var interactor: InteractorProtocol?
    
    var router: RouterProtocol?
    
    func startFetchingUserData() {
        self.interactor?.fetchData()
    }
    
    func fetchImageData(urlString: String, assetID: String) {
        self.interactor?.getImageData(urlString: urlString, assetID: assetID)
    }
    func onImageDownload(state: Bool, assetId: String) {
        self.view?.onImageDownload(state: state, assetId: assetId)
    }
    
    func onData(result: [Asset]) {
        self.view?.onData(data: result)
        
    }
    
    func onError(error: Error) {
        self.view?.onError(error: error)
    }
    
    func moveToDetailedViewController(navigationController: UINavigationController, asset: Asset) {
        self.router?.pushToDetailedVC(navigationController, asset: asset)
    }
    
    func moveToCartsVC(_ navigationController: UINavigationController) {
        self.router?.pushCartsVC(navigationController)
    }
}
