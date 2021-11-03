//
//  CartData+CoreDataProperties.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//
//

import Foundation
import CoreData


extension CartData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartData> {
        return NSFetchRequest<CartData>(entityName: "CartData")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var assetdescription: String?
    @NSManaged public var price: String?

}

extension CartData : Identifiable {

}
