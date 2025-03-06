//
//  CartView2.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 08/01/2023.
//

import SwiftUI

struct CartView: View {
    @State var ordered:Bool = false
    @State var nullorder:Bool = false
    @State var backtomain: Bool = false
    @State var showalert: Bool = false
    let id = UUID()
    @EnvironmentObject var filestoremanager: FirestoreManager
    var body: some View {
        NavigationStack{
            let total = filestoremanager.ordertotal(cart: Cart(user: user,order: foodordered))
            VStack{
                List(foodordered){
                    Order in DetailRowCart(order: Order)
                }
                Spacer()
                HStack{
                    Text("Total RM: \(total,specifier: "%.2f")")
                    Button(action:  {
                        foodordered.removeAll()
                        backtomain = true
                    })
                    {
                        Text("Clear All")
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 50)
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                    Button(action:  {
                        if foodordered.isEmpty{
                            nullorder = true
                            ordered = false
                            showalert = true
                        }
                        else{
                            ordered = true
                            nullorder = false
                            showalert = true
                            filestoremanager.addOrder(cart: Cart(user: user,order: foodordered))
                            print("Order Requested to server")
                        }
                    })
                    {
                        Text("ORDER")
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .alert(isPresented: $showalert){
                        switch ordered{
                        case true: return Alert(title: Text("Order Received"),message: Text("Please wait for your food to be served"),dismissButton: .cancel(Text("OK")){
                            backtomain = true
                        })
                        case false: return Alert(title: Text("No order found"),message: Text("Please make sure you ordered something"),dismissButton: .cancel(Text("OK")))
                        }
                    }
                    .navigationDestination(isPresented: $backtomain){
                        WelcomeScreen().navigationBarBackButtonHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }.navigationTitle(Text("Cart"))
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
