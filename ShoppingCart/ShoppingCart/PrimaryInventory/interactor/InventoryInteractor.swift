//
//  InventoryInteractor.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 02/11/21.
//

import Foundation
protocol InteractorProtocol: class {
    var presenter:PresenterProtocol? {get set}
    func fetchData()
    func getImageData(urlString: String,
                      assetID: String)
}

class InventoryInteractor: InteractorProtocol {
    var presenter: PresenterProtocol?
    var userData = [Asset]()
    
    func fetchData() {
        if userData.isEmpty {
            getUserData()
        } else {
            self.presenter?.onData(result: userData)
        }
        
    }
    
    func getUserData() {
        guard let url = URL(string: "https://60d2fa72858b410017b2ea05.mockapi.io/api/v1/menu") else { return }
        RestClient().getData(aURL: url, model: [Asset].self) { (result) in
            switch result {
            case .success(let data):
                self.presenter?.onData(result: data)
            case .failure(let error):
                self.presenter?.onError(error: error)
            }
            
        }
    }
    
    func getImageData(urlString: String,
                      assetID: String) {
        guard let aURl = URL(string:urlString) else { return }
        
        RestClient().downloadImage(aURL: aURl) { [weak self](result) in
            switch result {
            case .success(let data):
                let state = UtilityManager.saveImageToLocal(name: assetID, data: data)
                self?.presenter?.onImageDownload(state: state , assetId: assetID)
            case .failure( _):
                self?.presenter?.onImageDownload(state: false, assetId: assetID)
            }
        }
    }
}
