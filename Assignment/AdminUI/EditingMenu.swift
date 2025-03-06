//
//  EditingMenu.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 06/01/2023.
//

import SwiftUI
struct EditingMenu: View {
    let food:Food
    @EnvironmentObject var filestoremanager: FirestoreManager
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var category: String = ""
    @State private var image: String = ""
    @State var edited: Bool = false
    var body: some View {
        GeometryReader{ geo in
            NavigationStack{
                ZStack{
                    Image("loginbackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(0.5)
                    VStack{
                        Text("iFood Edit Menu")
                            .padding(.bottom,100)
                            .bold()
                            .font(.custom("Arial", size: 20))
                        ZStack{
                            Text("")
                                .background(Color.white.opacity(0.5).cornerRadius(100).frame(width:300, height: 50))
                                .foregroundColor(.black)
                                .font(.callout)
                                .frame(width: 300,height: 50)
                                .padding()
                            HStack{
                                Text(name)
                                    .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:300, height: 50))
                                    .onAppear{
                                        self.name = food.title
                                    }
                                    .foregroundColor(.black)
                                    .font(.callout)
                                    .frame(width: 300,height: 50)
                                    .padding()
                            }
                        }
                        ZStack{
                            Text("")
                                .background(Color.white.opacity(0.5).cornerRadius(100).frame(width:300, height: 50))
                                .foregroundColor(.black)
                                .font(.callout)
                                .frame(width: 300,height: 50)
                                .padding()
                            HStack{
                                Spacer().frame(width: 20,alignment: .trailing)
                                TextField("Price", text: $price)
                                    .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:300, height: 50))
                                    .onAppear{
                                        self.price = String(format:"%.2f",food.price)
                                    }
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.black)
                                    .font(.callout)
                                    .frame(width: 300,height: 50)
                                    .padding()
                            }
                        }
                        
                        Menu{
                            Button(action: {
                                category = "burger"
                            }, label:{ Text("Burger")
                            })
                            Button(action: {
                                category = "pasta"
                            }, label:{ Text("Pasta")
                            })
                            Button(action: {
                                category = "desserts"
                            }, label:{ Text("Desserts")
                            })
                            Button(action: {
                                category = "pizza"
                            }, label:{ Text("Pizza")
                            })
                            Button(action: {
                                category = "drinks"
                            }, label:{ Text("Drinks")
                            })
                        } label: {
                            Text("\(category)")
                        }
                        .onAppear{
                            switch food.category{
                            case .burger:
                                self.category = "burger"
                            case .desserts:
                                self.category = "desserts"
                            case .pizza:
                                self.category = "pizza"
                            case .pasta:
                                self.category = "pasta"
                            case .drinks:
                                self.category = "drinks"
                            }
                        }
                        
                        ZStack{
                            Text("")
                                .background(Color.white.opacity(0.5).cornerRadius(100).frame(width:300, height: 50))
                                .foregroundColor(.black)
                                .font(.callout)
                                .frame(width: 300,height: 50)
                                .padding()
                            HStack{
                                Spacer().frame(width: 20,alignment: .trailing)
                                TextField("Image", text: $image)
                                    .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:300, height: 50))
                                    .foregroundColor(.black)
                                    .font(.callout)
                                    .padding(.vertical,10)
                                    .frame(width: 250,height: 50)
                                    .onAppear{
                                        self.image = food.image
                                    }
                            }
                        }
                        
                        Button("Edit", action: {
                            filestoremanager.addMenu(foodname: name, price: Double((price as NSString).doubleValue), category: category, image: image)
                            edited = true
                        })
                        .alert(isPresented: $edited){
                            Alert(title: Text("Edited Successfully!"),message: Text("Menu will now visible to  customer"),dismissButton: .cancel(Text("OK")))
                        }
                    }
                }
            }
        }
    }
}

/*struct EditingMenu_Previews: PreviewProvider {
    static var previews: some View {
        EditingMenu(food: foodData[0])
    }
}*/
