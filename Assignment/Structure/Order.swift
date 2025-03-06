//
//  Order.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 28/12/2022.
//

import Foundation

struct Order: Identifiable{
    var order: Food
    var amount: Int
    let id = UUID()
}
