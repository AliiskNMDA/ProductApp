//
//  OrderStatus.swift
//  ProductApp
//
//  Created by Yusup Aliskantiev on 15.03.2023.
//

import Foundation


enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case copmleted = "Выполнен"
    case cancelled = "Отменен"
}
