//
//  DatabaseService.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 14.03.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference { return db.collection("users")}
    private var orderRef: CollectionReference { return db.collection("orders")}
    private var productRef: CollectionReference {return db.collection("products")}
    
    private init(){}
  
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionRef = orderRef.document(orderID).collection("positions")
        positionRef.getDocuments { qSnap, error in
            if let querySnapshot = qSnap {
                var positions = [Position]()
                for doc in querySnapshot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getOrders(by userId: String?,
                   completion: @escaping (Result<[Order], Error>) -> ()) {
        self.orderRef.getDocuments { qSnap, error in
            if let qSnap = qSnap{
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userId = userId {
                        if let order = Order(doc: doc), order.userId == userId {
                            orders.append(order)
                        }
                        
                    }else { // ветка Админа
                        if let order = Order(doc: doc){
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
       
        }
    }
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        orderRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            
            }else {
                self.setPositions(to: order.id, positions: order.positions) { result in
                    switch result {
                        
                    case .success(let positions):
                        print(positions.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setPositions(to orderId: String, positions: [Position],
                     completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionRef = orderRef.document(orderId).collection("positions")
        
        for position in positions {
            positionRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
    }
    
    func setProfile(user: UserInfo, complition: @escaping (Result<UserInfo, Error>)->()){
        usersRef.document(user.id).setData(user.representation) { error in
            if let error {
                complition(.failure(error))
            } else {
                complition(.success(user ))
            }
        }
        
    }
    
    func getProfile(by userId: String? = nil,  complition: @escaping (Result<UserInfo, Error>)->()) {
        usersRef.document(userId != nil ? userId! : AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let snapshot = docSnapshot else {return}
            guard let data = snapshot.data() else {return}
            
            guard let userName = data["name"] as? String else {return}
            guard let userId = data["id"] as? String else {return}
            guard let userPhone = data["phone"] as? Int else {return}
            guard let userAdress = data["adress"] as? String else {return}
            
            let user = UserInfo(id: userId, name: userName, phone: userPhone, adress: userAdress)
            complition(.success(user))
        }
    }
    
    func setProduct (product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()){
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
            case .success(let sizeInfo):
               print(sizeInfo)
                self.productRef.document(product.id).setData(product.representation) { error in
                    if let error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
