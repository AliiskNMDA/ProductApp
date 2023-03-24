//
//  PositionCell.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 10.03.2023.
//

import SwiftUI

struct PositionCell: View {
    let position: Position
    
    var body: some View {
        HStack {
//            Image(position.product.imageURL)
//                .resizable()
//                .frame(width: 70, height: 70)
//                .cornerRadius(20)
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.cost) ₽")
                .frame(width: 85, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(position: Position(id: UUID().uuidString, product: Product(id: UUID().uuidString, title: "Маргарита",  price: 350, descript: "tratata"), count: 3))
    }
}
