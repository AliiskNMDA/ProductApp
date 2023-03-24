//
//  ContentView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isAuth = true
    @State private var isTabBarShow = false
    @State private var AlertMessage = ""
    @State private var isShowAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isAuth ? "Авторизация ◉" : "Новый пользователь ◎")
                .padding()
                .padding(.horizontal, 40)
                .font(.title2.bold())
                .background(Color("whiteAlpha"))
                .cornerRadius(30)
                .foregroundColor(.black)
            
            VStack {
                
                TextField("Введите email", text: $email)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                
                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                    .foregroundColor(.black)
                    
                
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .background(password == confirmPassword && !password.isEmpty ? Color("passwordColor") : Color("whiteAlpha"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                    
                }
                
                
                Button {
                    if isAuth {
                        
                        print("авторизация")
                        AuthService.shared.signIn(email: email, password: password) { result in
                            switch result {
                                
                            case .success(_):
                                isTabBarShow.toggle()
                            case .failure(let error):
                                AlertMessage = "Ошибка авторизации \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                    } else {
                        
                        guard password == confirmPassword else {
                            AlertMessage = "пароли не совпадают!"
                            self.isShowAlert.toggle()
                            return
                        }
                        AuthService.shared.signUp(email: self.email, password: self.password) { result in
                            switch result {
                                
                            case .success(let user):
                                AlertMessage = "Вы зарегистрировались с \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                                
                            case .failure(let error):
                                AlertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                self.isShowAlert.toggle()
                            }
                        }
                        
                        print("регистрация ")
                    }
                } label: {
                    Text(isAuth ? "Войти" : "Регистрация")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [Color("yellow"), Color("orange")],
                                startPoint: .leading,
                                endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }
                
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Есть аккаунт!")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .font(.title3.bold())
                        .foregroundColor(Color("brown"))
                }
            }
            .padding()
            .padding(.top)
            .background(Color("whiteAlpha"))
            .cornerRadius(20)
            .padding(isAuth ? 20 : 12)
            .alert(AlertMessage, isPresented: $isShowAlert) {
                Button {} label: {
                    Text("OK")
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .background(Image("BG")
            .ignoresSafeArea()
            .blur(radius: isAuth ? 0 : 3))
        .animation(Animation.spring(), value: isAuth)
        .fullScreenCover(isPresented: $isTabBarShow) {
            
            if AuthService.shared.currentUser?.uid == "EvtTYrylu8gmYzwMqgEHFYBoxRq1" {
                AdminOrdersView()
            } else {
                let mainTabBarViewModel = MainTabBarViewModel(
                    user: AuthService.shared.currentUser!)
                
                MainTabBar(viewModel: mainTabBarViewModel)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
