//
//  AdminOrdersViewModel.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 21.03.2023.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    var currentOrder = Order(userId: "", date: Date(), status: "Новый")
    
    func getOrders(){
        DatabaseService.shared.getOrders(by: nil) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                for (index, order) in orders.enumerated() {
                    DatabaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } 
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
