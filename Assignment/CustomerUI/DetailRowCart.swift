//
//  DetailRowCart.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 08/01/2023.
//

import SwiftUI

struct DetailRowCart: View {
    let order:Order
    @EnvironmentObject var filestoremanager: FirestoreManager
    @State private var editpage = false
    @State private var deletemenu = false
    @State private var mainmenu = false
    @State private var splashscreen = false
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: order.order.image), transaction: .init(animation: .spring())){ phase in
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
                Text(order.order.title)
                    .font(.headline)
                    .padding([.top, .leading],10)
                Text("\(order.amount)x RM \(order.order.price,specifier:"%2.2f")")
                    .font(.caption)
                    .padding(.leading)
            }
            Spacer()
            Button(action:  {
                foodordered.removeAll(where:{ Order in
                    Order.order.title == order.order.title
                })
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
                Alert(title: Text("Deleted Order from Cart"),message: Text("You can continue your other order and confirm order once you're done."),dismissButton: .cancel(Text("OK")){
                        splashscreen = true
                })
            }
            .navigationDestination(isPresented: $splashscreen){
                WelcomeScreen().navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
            }

        }
        .padding(20)
    }
}

/*struct DetailRowCart_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowCart()
    }
}*/
