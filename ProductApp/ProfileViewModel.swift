//
//  ProfileViewModel.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 14.03.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: UserInfo
    @Published var orders: [Order] = [Order]()

    
    init(profile: UserInfo) {
        self.profile = profile
    }
    
    func getOrders(){
        DatabaseService.shared.getOrders(by: AuthService.shared.currentUser!.uid) { result in
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
                print("Всего заказов \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile(){
        DatabaseService.shared.setProfile(user: self.profile) { result in
            switch result {
                
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("Ошибка синхронизации \(error.localizedDescription)")
            }
        }
    }
    
    func getProfile(){
        DatabaseService.shared.getProfile { result in
            switch result {
            case .success(let user):
                print("Профиль успешно получен")
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
