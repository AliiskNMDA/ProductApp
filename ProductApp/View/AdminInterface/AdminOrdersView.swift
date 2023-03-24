//
//  AdminOrdersView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 21.03.2023.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State var isOrderViewShow = false
    @State var isShowAuthView = false
    @State var isQuitAlertPresenter = false
    @State private var isShowAddProductView = false

    var body: some View {
        VStack {
            HStack {
                Button {
                   
                    isQuitAlertPresenter.toggle()
                } label: {
                    Text("Выход")
                        .foregroundColor(.red)
                }
                .padding(.trailing)
                Spacer()
                Button {
                    isShowAddProductView.toggle()
                } label: {
                    Text("Добавить товар")
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(15)
                }
                .confirmationDialog("Выйти из профиля?", isPresented: $isQuitAlertPresenter) {
                    Button(role: .destructive){
                        isShowAuthView.toggle()
                        AuthService.shared.signOut()
                    } label: {
                        Text("Выйти")
                    }
                }
            message: {
                Text("Выйти из профиля администратора?")
            }
                
                Spacer()
                Button {
                    viewModel.getOrders()
                } label: {
                    Text("Обновить")
                }
            }.padding()
               
            
            
            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isOrderViewShow.toggle()
                        }
                }
                
            }.listStyle(.plain)
                .onAppear {
                    self.viewModel.getOrders()
                }
                .sheet(isPresented: $isOrderViewShow) {
                    let orderViewModel = OrderViewModel(order: viewModel.currentOrder)
                    OrderView(viewModel: orderViewModel)
                }
        }.fullScreenCover(isPresented: $isShowAuthView) {
            AuthView()
        }
        .sheet(isPresented: $isShowAddProductView) {
            AddProductView()
        }
    }
}
struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
