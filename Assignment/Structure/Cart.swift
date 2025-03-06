//
//  Cart.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 28/12/2022.
//

import Foundation

struct Cart: Identifiable{
    let user: String
    let order: [Order]
    let id = UUID()
}
