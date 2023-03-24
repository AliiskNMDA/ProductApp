//
//  AddProductView.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 23.03.2023.
//

import SwiftUI

struct AddProductView: View {
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "pizzaPH")!
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var price: Int? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Добавить товар")
                .font(.title2.bold())
            
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: screen.width - 20, maxHeight: screen.width - 20)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
                .onTapGesture {
                    showImagePicker.toggle()
                }
            TextField("Название продукта", text: $title)
                .padding()
            TextField("Описание продукта продукта", text: $description)
                .padding()
            TextField("Цена продукта", value: $price, format: .number)
                .keyboardType(.numbersAndPunctuation)
                .padding()
            
           
            Button {
                guard let price = price else {
                    print("Неправельная цена")
                    return
                }
                let product = Product(id: UUID().uuidString, title: title, price: price, descript: description)
                guard let imageData = image.jpegData(compressionQuality: 0.15) else {return}
                DatabaseService.shared.setProduct(product: product, image: imageData) { result in
                    switch result {
                    case .success(let product):
                        print(product.title)
                        dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } label: {
               Text("Сохранить")
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            
            Spacer()

        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourseType: .photoLibrary, selectedImage: $image)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
