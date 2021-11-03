//
//  CoreDataManager.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {
    }
    
    let aContext:NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()
    
    func getAllItems() -> [Asset]? {
        let items = try? aContext.fetch(CartData.fetchRequest()) as? [CartData]
        
        let assets = items?.compactMap({
            Asset(id: $0.id ?? "",
                  name: $0.name ?? "" ,
                  image: $0.image ?? "",
                  description: $0.assetdescription ?? "",
                  price: $0.price ?? "")
        })
        
        return assets
    }
    
    func addItem(_ asset: Asset) {
        let aNewItem = CartData(context: aContext)
        aNewItem.id = asset.id
        aNewItem.name = asset.name
        aNewItem.image = asset.image
        aNewItem.assetdescription = asset.description
        aNewItem.price = asset.price
        
        do {
            try aContext.save()
        } catch {
            print(error)
        }
    }
    
    func deleteItem(asset: Asset) {
        if let aData = self.getDataFor(asset) {
            aContext.delete(aData)
            do {
                try aContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func getDataFor(_ asset: Asset) -> CartData? {
        let aFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartData")
        aFetchRequest.fetchLimit = 1
        aFetchRequest.predicate = NSPredicate(format: "id == %@", asset.id ?? "")
        
        do {
            let aData = try aContext.fetch(aFetchRequest) as? [CartData]
            
            return aData?.first
        } catch {
            
        }
        
        return nil
    }
}
