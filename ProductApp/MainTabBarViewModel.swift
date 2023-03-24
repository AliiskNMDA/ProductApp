//
//  MainTabBarViewModel.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 14.03.2023.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User){
        self.user = user 
    }
}
