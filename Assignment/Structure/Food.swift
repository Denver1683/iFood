//
//  Food.swift
//  FoodDeliveryApp
//
//  Created by Denver Alfito Anggada on 01/11/2022.
//

import Foundation

struct Food: Identifiable{
    let title: String
    let price: Double
    let category: Categories
    let image: String
    let id = UUID()
}
