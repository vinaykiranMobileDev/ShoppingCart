//
//  RestClient.swift
//  ShoppingCart
//
//  Created by VinayKiran M on 03/11/21.
//

import Foundation
import UIKit

enum CustomError: Error {
    case invalidData
    case unknownException
}

class RestClient {
    lazy var session = URLSession.shared
    
    func getData<T: Codable>(aURL : URL,
                             model: T.Type,
                             completionHandler: @escaping (Result<T, Error>) -> Void) {
        let _ = session.dataTask(with: aURL) { (data, response, error) in
            guard let aData = data else {
                if let aError = error {
                    completionHandler(.failure(aError))
                } else {
                    completionHandler(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let aData = try JSONDecoder().decode(model, from: aData)
                completionHandler(.success(aData))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
    
    func downloadImage(aURL: URL,
                       completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let _ = session.downloadTask(with: aURL) { (url, response, error) in
            if let aLoclaURL = url,
               let aImageData = try? Data(contentsOf: aLoclaURL) {
                completionHandler(.success(aImageData))
            } else {
                completionHandler(.failure(CustomError.invalidData))
            }
        }.resume()
    }
}
