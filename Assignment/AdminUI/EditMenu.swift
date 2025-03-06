//
//  EditMenu.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 28/12/2022.
//

import SwiftUI
struct EditMenu: View {
    var body: some View {
        List(foodData){
            Food in DetailRowEdit(food:Food)
        }
    }
}

/*struct EditMenu_Previews: PreviewProvider {
    static var previews: some View {
        EditMenu(food: foodData[0])
    }
}*/
