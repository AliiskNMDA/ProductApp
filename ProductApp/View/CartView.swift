//
//  CartView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel: CartViewModel
    var body: some View {
        VStack {
            if viewModel.positions.isEmpty {
                    Text("Корзина пока пуста, как и твоя жизнь 😊")
                        .font(Font(CTFont(.label, size: 40)))
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)
                        .foregroundColor(.red)
                        .bold()
                        .padding()
                        .italic()
                }
                List(viewModel.positions) { position in
                    PositionCell(position: position)
                        .swipeActions {
                            Button {
                                viewModel.positions.removeAll { pos in
                                    pos.product.id == position.product.id
                                }
                            } label: {
                                Image(systemName: "trash")
                                
                            } .tint(.red)
                        }
                }
                
                .listStyle(.plain)
                .navigationTitle("Корзина")
     
                
                HStack{
                    Text("ИТОГО:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(viewModel.cost) ₽")
                        .fontWeight(.bold)
                }.padding()
                
                HStack(spacing: 24) {
                    Button {
                        print("отмена")
                    } label: {
                        Text("Отменить")
                            .font(.body)
                            .bold()
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(20)
                    }
                    Button {
                        print("заказать")
                         
                        var order = Order(userId: AuthService.shared.currentUser!.uid,
                                          date: Date(),
                                          status: OrderStatus.new.rawValue)
                        order.positions = self.viewModel.positions
                        
                        DatabaseService.shared.setOrder(order: order) { result in
                            switch result {
                            case .success(let order):
                                print(order.cost)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        
                    } label: {
                        Text("Заказать")
                            .font(.body)
                            .bold()
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(.green)
                            .cornerRadius(20)
                    }
                    
                }
                .padding()
            }
          
        }
       
    
} 

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
