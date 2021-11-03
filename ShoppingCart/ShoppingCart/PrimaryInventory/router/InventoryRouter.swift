//
//  InventoryRouter.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 02/11/21.
//

import Foundation
import UIKit

protocol RouterProtocol: class {
    static func getInventoryVC()-> UIViewController
    func pushToDetailedVC(_ navigationConroller:UINavigationController,asset: Asset)
    func pushCartsVC(_ navigationConroller:UINavigationController)
}

class InventoryRouter: RouterProtocol {
    func pushToDetailedVC(_ navigationConroller: UINavigationController, asset: Asset) {
        let aVC = DetailedViewRouter.getDetailedVC(asset: asset)
        navigationConroller.pushViewController(aVC, animated: true)
    }
    
    func pushCartsVC(_ navigationConroller: UINavigationController) {
        let aVC = MyCartRouter.getMyCatVC()
        navigationConroller.pushViewController(aVC, animated: true)
    }
    
    static func getInventoryVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let aController = storyboard.instantiateViewController(withIdentifier: "InventoryVC")  as? InventoryVC else {
            return UIViewController()
        }
        
        let presenter: PresenterProtocol   = InventoryPresenter()
        let interactor: InteractorProtocol = InventoryInteractor()
        let router:RouterProtocol = InventoryRouter()
        
        aController.presentor = presenter
        presenter.view = aController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return aController
    }
}
