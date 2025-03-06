//
//  UserDetails.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 03/01/2023.
//

import SwiftUI
import Firebase

struct UserDetails: View {
    @State var password = ""
    @State var logout: Bool = false
    @State var changepassword: Bool = false
    @EnvironmentObject var filestoremanager: FirestoreManager
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("loginbackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .opacity(0.5)
                
                VStack{
                    Text("Hello, \(user)")
                    ZStack{
                        Text("")
                            .background(Color.white.opacity(0.5).cornerRadius(100).frame(width:300, height: 50))
                            .foregroundColor(.black)
                            .font(.callout)
                            .frame(width: 100,height: 50)
                            .padding()
                        HStack{
                            Spacer().frame(width: 10,alignment: .trailing)
                            TextField("New Password", text: $password)
                                .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:100, height: 50))
                                .foregroundColor(.black)
                                .font(.callout)
                                .frame(width: 100,height: 50)
                                .padding()
                            Button(action: {
                                changepassword = true
                                filestoremanager.changePassword(password: password)
                            }, label: {
                                VStack{
                                    Text("Change Password")
                                        .foregroundColor(.red)
                                }
                            })
                            .alert(isPresented: $changepassword){
                                Alert(title: Text("Password Changed!"),message: Text("You can use your new password now"),dismissButton: .cancel(Text("OK")))
                            }
                        }
                    }
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do{
                            try firebaseAuth.signOut()
                            user = Auth.auth().currentUser?.email ?? ""
                            logout = true
                            foodordered = []
                            UserDefaults.standard.removeObject(forKey: "user_uid_key")
                                        UserDefaults.standard.synchronize()
                        } catch let signOutError as NSError{
                            print("Error signing out: %@",signOutError)
                        }
                    }, label: {
                        Text("Log Out")
                    })
                    .navigationDestination(isPresented: $logout){
                        ContentView().navigationBarBackButtonHidden(true)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }
}

/*struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserDetails()
    }
}*/
