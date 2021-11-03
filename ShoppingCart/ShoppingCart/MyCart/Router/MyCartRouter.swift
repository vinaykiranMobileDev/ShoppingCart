//
//  MyCartRouter.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

protocol MyCartRouterProtocol {
    static func getMyCatVC() -> UIViewController
}

class MyCartRouter: MyCartRouterProtocol {
    static func getMyCatVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let aController = storyboard.instantiateViewController(withIdentifier: "MyCartVC")  as? MyCartVC else {
            return UIViewController()
        }
        
        var presenter: MyCartPresenterProtocol = MyCartPresenter()
        var interactor: MyCartInteractorProtocol = MyCartInteractor()
        let router: MyCartRouterProtocol = MyCartRouter()
        
        aController.presentor = presenter
        presenter.view = aController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return aController
    }
}
