//
//  ProductDetailView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 10.03.2023.
//

import SwiftUI

struct ProductDetailView: View {
    
    var viewModel: ProductDatailViewModel
    @State  var size = "Маленькая"
    @State  var count = 1
    @Environment(\.dismiss) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Image("pizzaPH")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 360)
                        
                    HStack {
                        Text("\(viewModel.product.title)")
                            .font(.title2.bold())
                        Spacer()
                        Text("\(viewModel.getPrice(size: size)) ₽")
                            .font(.title2)
                        
                    }
                    .padding(.horizontal, 20)
                    
                    Text("\(viewModel.product.descript)")
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    HStack {
                        Stepper("Количество", value: $count, in: 1...10)
                        
                        Text("\(count)")
                            .padding(.horizontal)
                    }.padding(.horizontal)
                    
                    Picker(selection: $size) {
                        ForEach(viewModel.sizes, id: \.self) { item in
                            Text(item)
                        }
                    } label: {
                        Text("Размер пиццы")
                    }.pickerStyle(.segmented)
                        .padding()
                    
                }
                Button {
                    var position = Position(id: UUID().uuidString,
                                            product: viewModel.product,
                                            count: self.count)
                    position.product.price = viewModel.getPrice(size: size)
                    
                    CartViewModel.shared.addPosition(position)
    //                presentationMode.wrappedValue.dismiss()
                    presentationMode.callAsFunction()
                } label: {
                    Text("В корзину")
                        .padding()
                        .padding(.horizontal, 50)
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .font(.title3.bold())
                        .background(
                            LinearGradient(
                                colors: [Color("yellow"), Color("orange")],
                                startPoint: .leading,
                                endPoint: .trailing))
                        .cornerRadius(20)
                }
                Spacer()
            }
        }.navigationBarTitleDisplayMode(.inline)
            
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDatailViewModel(product: Product(
            id: "1",
            title: "Маргарита",
//            imageURL: "Не найден",
            price: 450,
            descript: "Такая себе пицца")))
    }
}
