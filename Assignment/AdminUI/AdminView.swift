//
//  AdminView.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 28/12/2022.
//

import SwiftUI

struct AdminView: View {
    @State var addmenu : Bool = false
    @State var editmenu : Bool = false
    @State var vieworder : Bool = false
    @State var logout: Bool = false
    @EnvironmentObject var filestoremanager: FirestoreManager
    var body: some View {
        NavigationStack{
            GeometryReader{ geo in
                ZStack{
                    Image("loginbackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(0.5)
                    VStack{
                        Button("iFood Admin Page", action: {
                            logout = true
                        })
                        .navigationDestination(isPresented:$logout){
                            ContentView().navigationBarBackButtonHidden(true)
                            .navigationBarTitleDisplayMode(.inline)}
                        .bold()
                        .font(.custom("Arial", size: 20))
                        .foregroundColor(.black)
                        List {
                            NavigationLink("Add Menu", destination: AddMenu())
                            NavigationLink("Edit/Delete Menu", destination: EditMenu().onAppear{
                                foodData=[]
                                filestoremanager.fetchFood()
                            })
                            NavigationLink("View Order", destination: ViewOrder().onAppear{
                                orderList=[]
                                filestoremanager.fetchOrder()
                            })
                        }.frame(height: 200)
                    }
                }
            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
