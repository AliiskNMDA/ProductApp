//
//  CatalogView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import SwiftUI

struct CatalogView: View {
    
    let layout = [GridItem(.adaptive(minimum: screen.width / 2.4))]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 15) {
                        ForEach(CatalogViewModel.shared.popularProducts, id:\.id) { item in
                            NavigationLink {
                                
                                let viewModel = ProductDatailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.primary)
                            }
                        }
                    }.padding()
                }
            }
            Section("Пицца") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layout, spacing: 15) {
                        ForEach(CatalogViewModel.shared.popularProducts, id:\.id) { item in
                            NavigationLink {
                                let viewModel = ProductDatailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }.padding(.horizontal, 10)
            }
            
        }.navigationTitle(Text("Каталог"))
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
