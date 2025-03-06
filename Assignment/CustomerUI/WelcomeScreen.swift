//
//  WelcomeScreen.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 07/01/2023.
//

import SwiftUI

struct WelcomeScreen: View {
    @State var mmenu = false
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
                        Button(action: {
                            mmenu = true
                        }, label: {
                            VStack{
                                Text("Welcome to iFood")
                                    .font(.custom("Arial", size: 30))
                                    .foregroundColor(.black)
                                Text("Tap me to continue")
                                    .font(.custom("Arial", size: 12))
                                    .foregroundColor(.black)
                            }
                        })
                        .navigationDestination(isPresented: $mmenu){
                            MainMenu().navigationBarBackButtonHidden(true)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
            }
        }
    }
}

/*struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}*/
