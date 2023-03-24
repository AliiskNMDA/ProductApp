//
//  ProductCell.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import SwiftUI

struct ProductCell: View {
    
    var product: Product
    
    var body: some View {
        VStack(spacing: 4) {
            Image("pizzaPH")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
            
            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regilar", size: 16))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 16))
            }.padding(.leading, 5)
                .padding(.trailing, 5)
                .padding(.bottom, 8)
            
        }
        .frame(width: screen.width * 0.45, height: screen.width * 0.55)
        .background(.white)
        .cornerRadius(16)
        .shadow(radius: 10)
   
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product:
                        Product(
                            id: "1",
                            title: "Маргарита",
//                            imageURL: "Не найден",
                            price: 450,
                            descript: "Такая себе пицца"))
    }
}
