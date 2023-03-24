//
//  Order.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 15.03.2023.
//

import Foundation
import FirebaseFirestore

struct Order {
    
    var id: String = UUID().uuidString
    var userId: String
    var positions = [Position]()
    var date: Date
    var status: String
    
    var cost: Int {
        var sum = 0
        
        for position in positions {
            sum += position.cost
        }
        return sum
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userId"] = userId
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        return repres
    }
    
    init(id: String = UUID().uuidString,
         userId: String,
         positions: [Position] = [Position](),
         date: Date,
         status: String) {
        self.id = id
        self.userId = userId
        self.positions = positions
        self.date = date
        self.status = status
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String  else {return nil}
        guard let userId = data["userId"] as? String  else {return nil}
        guard let date = data["date"] as? Timestamp  else {return nil}
        guard let status = data["status"] as? String  else {return nil}
        
        self.id = id
        self.userId = userId
        self.date = date.dateValue()
        self.status  = status
        
        }
    }

