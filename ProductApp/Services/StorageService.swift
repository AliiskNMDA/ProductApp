//
//  StorageService.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 23.03.2023.
//

import Foundation
import FirebaseStorage


class StorageService {
    
    static let shared = StorageService()
    private init (){}
    
    
    private var storage = Storage.storage().reference()
    private var productRef: StorageReference { storage.child("products")}
    
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> ()){
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        productRef.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata else {
                if let error {
                    completion(.failure(error))
                   
                }
                return
            }
            completion(.success("Размер полученного изображения \(metadata.size)"))
        }
        
    }
}

