//
//  MainMenu.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 26/12/2022.
//

import SwiftUI
struct MainMenu: View{
    @State var viewcart : Bool = false
    @State var viewuser : Bool = false
    @EnvironmentObject var filestoremanager: FirestoreManager
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Spacer().frame(width: 20,alignment: .trailing)
                    Button(action: {
                        viewuser=true
                    }, label: {
                        HStack{
                            Text("Hello, ")
                                .foregroundColor(.black)
                            Text(user)
                        }
                    })
                    .navigationDestination(isPresented: $viewuser){
                        UserDetails()
                    }
                    Spacer()
                    Button(action: {
                        viewcart=true
                    }, label: {
                        Image(systemName: "cart")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        
                    })
                    .navigationDestination(isPresented: $viewcart){
                        CartView()
                    }
                    Spacer().frame(width: 20,alignment: .trailing)
                }
                List {
                    NavigationLink(destination: DetailView(currentCategory: .burger).onAppear{
                        foodData=[]
                        filestoremanager.fetchFood()
                    }) {
                        CategoryView(imageName: "burger", categoryName: "BURGER")
                    }
                    NavigationLink(destination: DetailView(currentCategory: .pizza).onAppear{
                        foodData=[]
                        filestoremanager.fetchFood()
                    }) {
                        CategoryView(imageName: "pizza", categoryName: "PIZZA")
                    }
                    NavigationLink(destination: DetailView(currentCategory: .pasta).onAppear{
                        foodData=[]
                        filestoremanager.fetchFood()
                    }) {
                        CategoryView(imageName: "pasta", categoryName: "PASTA")
                    }
                    NavigationLink(destination: DetailView(currentCategory: .desserts).onAppear{
                        foodData=[]
                        filestoremanager.fetchFood()
                    }) {
                        CategoryView(imageName: "desserts", categoryName: "DESSERTS")
                    }
                    NavigationLink(destination: DetailView(currentCategory: .drinks).onAppear{
                        foodData=[]
                        filestoremanager.fetchFood()
                    }) {
                        CategoryView(imageName: "drinks", categoryName: "DRINKS")
                    }
                }
            }
        }
    }
}

struct CategoryView: View {
    
    let imageName: String
    let categoryName: String
    var body: some View{
        HStack {
            ZStack {
                Image(imageName).resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:300, height:150).clipped()
                    .cornerRadius(20)
                Text(categoryName)
                    .font(.custom("Arial", size: 40))
                    .foregroundColor(Color.white)
                    .padding()
            }
            Spacer()
        }
        .padding(.vertical, 5.0)
        .padding(.top,5.0)
        .padding(.bottom,5.0)
        
    }
}

/*struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(cart: cart, order: order)
    }
}*/
