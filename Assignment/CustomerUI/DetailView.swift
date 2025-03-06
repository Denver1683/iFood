//
//  DetailView.swift
//  FoodDeliveryApp
//
//  Created by Denver Alfito Anggada on 01/11/2022.
//

import SwiftUI

struct DetailView: View{
    let currentCategory: Categories
    var body: some View{
        List(filterData(foodDataSet: foodData, by: currentCategory)) {food in DetailRow(food: food)
        }
        .navigationTitle(Text(categoryString(for: currentCategory)))
    }
}

/*struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(currentCategory: .pasta)
    }
}*/

