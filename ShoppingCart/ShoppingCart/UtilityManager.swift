//
//  UtilityManager.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation

class UtilityManager {
    class func read(fromDocumentsWithFileName fileName: String) -> Data? {
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
    
    class func saveImageToLocal(name: String, data: Data) -> Bool {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(name)
            try data.write(to: fileURL)
            return true
            
        } catch {
            print(error)
            return false
        }
    }
}
