//
//  AcceptOrder.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 29/12/2022.
//

import Foundation

struct AcceptOrder: Identifiable{
    let user: String
    let order: [String]
    let amount: [Int]
    let id: String
    let price: Double
    let uid = UUID()
}
