//
//  ViewOrder.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 28/12/2022.
//

import SwiftUI

struct ViewOrder: View {
    @EnvironmentObject var filestoremanager: FirestoreManager
    @State var done = false
    
    var body: some View {
        VStack{
            List(orderList) { AcceptOrder in
                HStack{
                    VStack{
                        Text("\(AcceptOrder.user)")
                        HStack{
                            Text("\(AcceptOrder.order.joined(separator: "\n"))")
                            Text("\(AcceptOrder.amount.map(String.init).joined(separator: "\n"))")
                        }
                        Text("Total: RM \(AcceptOrder.price,specifier: "%.2f")")
                    }
                    Button(action:  {
                        done = true
                        filestoremanager.removeOrder(orderID: AcceptOrder.id)
                    })
                    {
                        Text("Done")
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .alert(isPresented: $done){
                        Alert(title: Text("Order Done"),message: Text("Please make sure customer pay full amount"),dismissButton: .cancel(Text("OK")))
                    }
                }
            }
        }.padding(20)
    }
}


/*struct ViewOrder_Previews: PreviewProvider {
    static var previews: some View {
        ViewOrder()
    }
}*/
