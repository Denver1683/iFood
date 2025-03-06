//
//  FoodData.swift
//  FoodDeliveryApp
//
//  Created by Denver Alfito Anggada on 01/11/2022.
//

import Foundation
import Firebase

    let db = Firestore.firestore()
    var foodData: [Food] = []
    let docRef = db.collection("Restaurant").document("Menu")
    docRef.getDocument { (document, error) in
    guard error == nil else {
        print("error", error ?? "")
        return
    }
    
    if let document = document, document.exists {
        let cat = document.documentID
        let data = document.data()
        if let data = data {
            print("data", data)
            let foodLine = [Food(title: data["name"] as? String ?? "" , price: data["price"] as? Double ?? 0.00, category: cat)]
            foodData.append(contentsOf:foodLine)
            
        }
    }
}

