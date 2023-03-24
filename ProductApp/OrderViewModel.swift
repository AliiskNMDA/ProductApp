//
//  OrderViewModel.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 21.03.2023.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var user = UserInfo(id: "", name: "", phone: 0, adress: "")
    
    init(order: Order) {
        self.order = order
    }
    
    func getUserData() {
        DatabaseService.shared.getProfile(by: order.userId) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
