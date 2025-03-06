//
//  DetailRowEdit.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 06/01/2023.
//

import SwiftUI

struct DetailRowEdit: View {
    let food:Food
    @EnvironmentObject var filestoremanager: FirestoreManager
    @State private var editpage = false
    @State private var deletemenu = false
    @State private var mainmenu = false
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: food.image), transaction: .init(animation: .spring())){ phase in
                switch phase{
                case .empty:
                    ProgressView().progressViewStyle(.circular)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure: Text("Failed fetching image. make sure to check your data")
                        .foregroundColor(.red)
                }
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading){
                Text(food.title)
                    .font(.headline)
                    .padding([.top, .leading],10)
                Text("RM \(food.price,specifier:"%2.2f")")
                    .font(.caption)
                    .padding(.leading)
            }
            Spacer()
            Button(action:  {
                filestoremanager.removeMenu(foodname: food.title)
                deletemenu = true
            })
            {
                Text("DELETE")
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 50)
            .background(Color.red)
            .cornerRadius(10)
            .alert(isPresented: $deletemenu){
                Alert(title: Text("Deleted Menu Successfully!"),message: Text("Menu will now removed from  customer"),dismissButton: .cancel(Text("OK")))
            }
        }
        .padding(20)
        .swipeActions(edge: .trailing, allowsFullSwipe: false){
            Button{
                editpage = true
            } label: {
                Image(systemName: "pencil")
                Text("Edit Menu")
            }
            .navigationDestination(isPresented:$editpage){
                EditingMenu(food:food)
            }
        }
    }
}

/*struct DetailRowEdit_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowEdit(food: foodData[0])
    }
}*/
