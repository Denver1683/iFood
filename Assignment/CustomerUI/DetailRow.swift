//
//  Detailrow.swift
//  FoodDeliveryApp
//
//  Created by Denver Alfito Anggada on 01/11/2022.
//

import SwiftUI
var foodordered:[Order]=[]
struct DetailRow: View {
    let food: Food
    @EnvironmentObject var filestoremanager: FirestoreManager
    @State var quantity: Int = 0
    @State var ordered : Bool = false
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
                Text("Quantity : \(self.quantity)")
                    .font(.caption)
                    .padding(.leading)
            }
            Spacer()
            VStack{
                Stepper(onIncrement:{
                    self.quantity += 1
                },onDecrement: {
                    if self.quantity <= 0{
                        
                    }
                    else if self.quantity > 0{
                        self.quantity -= 1
                    }
                }){
                    
                }
                Button(action:  {
                    if quantity > 0{
                        ordered = true
                        foodordered.append(Order(order: food, amount: quantity))
                    }
                })
                {
                    Text("ORDER")
                        .foregroundColor(.white)
                }
                .frame(width: 80, height: 50)
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.leading, 60)
                .alert(isPresented: $ordered){
                    Alert(title: Text("Added to cart"),message: Text("Open cart and press order to confirm order"),dismissButton: .cancel(Text("OK")))
                }
            }
        }
    }
}

/*struct Detailrow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(food: foodData[0])
    }
}*/
