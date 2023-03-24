//
//  MainTabBar.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import SwiftUI

struct MainTabBar: View {
  @StateObject  var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView {
            NavigationView {
                CatalogView()
            }
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Меню")
                    }
                }
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            
            ProfileView(viewModel: ProfileViewModel(
                profile: UserInfo(
                    id: "" ,
                    name: "",
                    phone: 94495845656,
                    adress: "")))
            
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
} 

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar(viewModel: MainTabBarViewModel(user: AuthService.shared.currentUser!))
    }
}
