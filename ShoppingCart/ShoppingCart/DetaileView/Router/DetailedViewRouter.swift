//
//  DetailedViewRouter.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

protocol DetailedViewRouterProtocol {
    static func getDetailedVC(asset: Asset) -> UIViewController
    func moveToMyCart(navigationVC: UINavigationController)
}

class DetailedViewRouter : DetailedViewRouterProtocol{
    func moveToMyCart(navigationVC: UINavigationController) {
        let aVC = MyCartRouter.getMyCatVC()
        navigationVC.pushViewController(aVC, animated: true)
    }
    
    static func getDetailedVC(asset: Asset) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let aController = storyboard.instantiateViewController(withIdentifier: "DetailedViewController")  as? DetailedViewController else {
            return UIViewController()
        }
        
        var presenter: DetailedViewPresenterProtocol = DetailedViewPresenter()
        var interactor: DetailedViewInteractorProtocol = DetailedViewInteractor()
        let router: DetailedViewRouterProtocol = DetailedViewRouter()
        
        aController.asset = asset
        aController.presentor = presenter
        presenter.view = aController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return aController
    }
    
    
    
}
