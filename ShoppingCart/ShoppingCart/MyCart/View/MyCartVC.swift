//
//  MyCartVC.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

protocol MyCartViewProtocol {
    func reloadData()
}

class MyCartVC: UIViewController, MyCartViewProtocol{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    var presentor: MyCartPresenterProtocol?
    var dataSource = [Asset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self.presentor?.fetchCartItems() ?? []
        tableView.dequeueReusableCell(withIdentifier: "MyCartCell")
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func checkoutButtonAction(_ sender: Any) {
        //To - Do
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MyCartVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aCell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as? MyCartCell else { return UITableViewCell() }
        
        aCell.configureWith(dataSource[indexPath.row])
        return aCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let aAsset = dataSource[indexPath.row]
            self.presentor?.deleteAsset(aAsset)
            self.dataSource.remove(at: indexPath.row)
            
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                self.tableView.endUpdates()
            }
        }
    }
}


class MyCartCell: UITableViewCell {
    
    @IBOutlet weak var assetImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureWith(_ asset: Asset) {
        self.titleLabel.text = asset.name
        self.priceLabel.text = "$ " + (asset.price ?? "")
        
        guard let aID = asset.id else { return }
        
        if let aImageData = self.read(fromDocumentsWithFileName: aID){
            assetImage.image = UIImage(data: aImageData)
            assetImage.layer.cornerRadius = 15
        }
    }
    
    private func read(fromDocumentsWithFileName fileName: String) -> Data? {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            let aData = try? Data(contentsOf: fileURL)
            return aData
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
