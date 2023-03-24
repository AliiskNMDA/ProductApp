//
//  ProfileView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAvaAlertPresenter = false
    @State var isQuitAlertPresenter = false
    @State var isAuthAlertPresenter = false
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: 16) {
                Image("user")
                    .resizable()
                    .frame(width: 80,height: 80)
                    .padding(8)
                    .background(.regularMaterial)
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvaAlertPresenter.toggle()
                    }
                    .confirmationDialog("", isPresented: $isAvaAlertPresenter) {
                        Button {
                            print("library")
                        } label: {
                            Text("Из галереи")
                        }
                        
                        Button(role: .none) {
                            print("камера")
                        } label: {
                            Text("Использовать камеру")
                        }
                        
                    } message: {
                        Text("Выбрать фото")
                            .bold()
                            .font(.title)
                    }
                
                
                VStack(alignment: .leading, spacing: 12){
                    TextField("Имя", text: $viewModel.profile.name)
                        .font(.body.bold())
                    
                    
                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $viewModel.profile.phone, format: .number)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки:")
                    .bold()
                TextField("Ваш адрес", text: $viewModel.profile.adress)
            }.padding(.horizontal)
            
            List {
                if viewModel.orders.count == 0 {
                    Text("Ваши заказы буду тут")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
            }.listStyle(.plain)
            
            Button {
                isQuitAlertPresenter.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                
            }.padding()
                .confirmationDialog("Выйти из профиля?", isPresented: $isQuitAlertPresenter) {
                    Button(role: .destructive){
                        isAuthAlertPresenter.toggle()
                    } label: {
                        Text("Выйти ")
                    }
                }
        message: {
            Text("Выйти из профиля?")
            
        }
        }.fullScreenCover(isPresented: $isAuthAlertPresenter) {
            AuthView()
            
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: UserInfo(id: "", name: "vasy shack", phone: 9893332233, adress: "adress")))
    }
}
