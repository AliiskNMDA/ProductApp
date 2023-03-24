//
//  ProductDatailViewModel.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 10.03.2023.
//

import Foundation

class ProductDatailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var sizes = ["Маленькая", "Средняя", "Большая" ]
    @Published var count: Int = 0
    
    
    func getPrice(size: String)-> Int{
        switch size {
        case "Маленькая": return product.price
        case "Средняя": return Int(Double(product.price) * 1.25)
        case "Большая": return Int(Double(product.price) * 1.5)
        default: return product.price
        }
    }
    
    init(product: Product) {
        self.product = product
    }
}
