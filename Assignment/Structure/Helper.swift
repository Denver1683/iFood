//
//  Helper.swift
//  FoodDeliveryApp
//
//  Created by Denver Alfito Anggada on 01/11/2022.
//

import Foundation

enum Categories{
    case burger
    case pasta
    case pizza
    case desserts
    case drinks
}

func filterData(foodDataSet: [Food], by category: Categories) -> [Food] {
    var filteredArray = [Food]()
    for food in foodDataSet {
        if food.category == category {
            filteredArray.append(food)
        }
    }
    return filteredArray
}

func categoryString (for category: Categories) -> String {
    switch category {
    case .pizza:
        return "Pizza"
    case .burger:
        return "Burger"
    case .pasta:
        return "Pasta"
    case .desserts:
        return "Desserts"
    case .drinks:
        return "Drinks"
    }
}
