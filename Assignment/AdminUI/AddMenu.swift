//
//  AddMenu.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 03/01/2023.
//

import SwiftUI

struct AddMenu: View {
    @State var foodname = ""
    @State var price = ""
    @State var category = "Please select category"
    @State var image = ""
    @State var addmenu : Bool = false
    @State var showalert : Bool = false
    @State var backtomain : Bool = false
    @EnvironmentObject var filestoremanager: FirestoreManager
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
                        Text("iFood Add Menu")
                            .padding(.bottom,100)
                            .bold()
                            .font(.custom("Arial", size: 20))
                        if foodname.isEmpty{
                            Text("")
                                .foregroundColor(.gray)
                        }
                        if price.isEmpty{
                            Text("")
                                .foregroundColor(.gray)
                        }
                        if image.isEmpty{
                            Text("")
                                .foregroundColor(.gray)
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
                                TextField("Food Name", text: $foodname)
                                    .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:300, height: 50))
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
                                    .keyboardType(.numberPad)
                                    .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:300, height: 50))
                                    .foregroundColor(.black)
                                    .font(.callout)
                                    .padding(.vertical,10)
                                    .frame(width: 300,height: 50)
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
                                    .frame(width: 300,height: 50)
                            }
                        }
                        
                        Button(action:{
                            if foodname.isEmpty||price.isEmpty||category=="Please select category"||image.isEmpty{
                                addmenu = false
                                showalert = true
                            }
                            else{
                                addmenu=true
                                showalert = true
                                print("Adding to database")
                                filestoremanager.addMenu(foodname: foodname, price: Double((price as NSString).doubleValue), category: category, image: image)
                            }
                        },label: {
                            Text("Add Menu")
                                .background(Color.white.opacity(0.8).cornerRadius(100).frame(width:300, height: 50))
                                .foregroundColor(.black)
                        })
                        .padding()
                        .alert(isPresented: $showalert){
                            switch addmenu{
                            case true: return Alert(title: Text("Added Menu Successfully!"),message: Text("Menu will now visible to  customer"),dismissButton: .cancel(Text("OK")){
                                backtomain = true
                            })
                            case false: return Alert(title: Text("Input not complete!"),message: Text("Please recheck your input"),dismissButton: .cancel(Text("OK")))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AddMenu_Previews: PreviewProvider {
    static var previews: some View {
        AddMenu()
    }
}
