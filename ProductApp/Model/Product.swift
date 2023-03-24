//
//  Product.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import Foundation

struct Product {
    var id: String
    var title: String
//    var imageURL: String
    var price: Int
    var descript: String
    
//    var ordersCount: Int
//    var isRecommend: Bool
    
    init(id: String, title: String, price: Int, descript: String) {
        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["descript"] = self.descript
        return repres
    }
}
