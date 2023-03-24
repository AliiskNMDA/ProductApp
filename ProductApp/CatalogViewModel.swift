//
//  CatalogViewModel.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 09.03.2023.
//

import Foundation


class CatalogViewModel: ObservableObject {
    static let shared = CatalogViewModel()
    
    
    var popularProducts: [Product] = [
        Product(
            id: "1",
            title: "Маргарита",
//            imageURL: "Не найден",
            price: 450,
            descript: "Такая себе пицца"),
        Product(
            id: "2",
            title: "Гавайская",
//            imageURL: "Не найден",
            price: 500,
            descript: "На любителя"),
        Product(
            id: "3",
            title: "Пеперони",
//            imageURL: "Не найден",
            price: 350,
            descript: "Норм пицца"),
        Product(
            id: "4",
            title: "С ананасами",
//            imageURL: "Не найден",
            price: 400,
            descript: "Лучше не брать"),
        Product(
            id: "5",
            title: "Сырная",
//            imageURL: "Не найден",
            price: 550,
            descript: "Очень вкусная пицца")
    
    ]
    
    
    var pizza: [Product] = [
        Product(
            id: "1",
            title: "Маргарита",
//            imageURL: "Не найден",
            price: 450,
            descript: "Такая себе пицца"),
        Product(
            id: "2",
            title: "Гавайская",
//            imageURL: "Не найден",
            price: 500,
            descript: "На любителя"),
        Product(
            id: "3",
            title: "Пеперони",
//            imageURL: "Не найден",
            price: 350,
            descript: "Норм пицца"),
        Product(
            id: "4",
            title: "С ананасами",
//            imageURL: "Не найден",
            price: 400,
            descript: "Лучше не брать"),
        Product(
            id: "5",
            title: "Сырная",
//            imageURL: "Не найден",
            price: 550,
            descript: "Очень вкусная пицца")
    
    ]
}
