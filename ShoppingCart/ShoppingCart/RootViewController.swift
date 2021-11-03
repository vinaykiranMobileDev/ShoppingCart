//
//  ViewController.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 02/11/21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBaseController()
    }

    func loadBaseController() {
        let aController = InventoryRouter.getInventoryVC()
        self.navigationController?.pushViewController(aController, animated: false)
    }
}

