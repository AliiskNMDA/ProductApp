//
//  OrderView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 21.03.2023.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel: OrderViewModel
    var statuses: [String] {
        var sts = [String]()
        
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.user.name)")
                .font(.title3.bold())
            Text("\(viewModel.user.phone)")
                .bold()
            Text("\(viewModel.user.adress)")
            
            Picker(selection: $viewModel.order.status) {
                ForEach(statuses, id: \.self) { status in
                    Text(status)
                }
            } label: {
                Text("Статус заказа")
            }.pickerStyle(.segmented)
                .onChange(of: viewModel.order.status) { newValue in
                    DatabaseService.shared.setOrder(order: viewModel.order) { result in
                        switch result {
                        case .success(let order):
                            print(order.status)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }

            
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
            }.cornerRadius(15)
            
            Text("Итого \(viewModel.order.cost) ₽")
                .font(.title2.bold())
        }
        .onAppear {
            viewModel.getUserData()
        }
        .padding()
    }
}

//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderView(viewModel: OrderViewModel(order: Order(
//            userId: "",
//            date: Date(),
//            status: "новый")))
//    }
//}
