//
//  ContentView.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 26/12/2022.
//

import SwiftUI
import Firebase
var user:String = Auth.auth().currentUser?.email ?? ""
var cart: Cart?? = nil
struct ContentView: View {
    @State var email = ""
    @State var password = ""
    @State var loggedin : Bool = false
    @State var failedlogin : Bool = false
    @State var failedsignup : Bool = false
    @State var forgotpassword : Bool = false
    @State var admin : Bool = false
    @State var nullinput : Bool = false
    @State var showalert = false
    @State var showalert2 = false
    @State var showalert3 = false
    @EnvironmentObject var firestoreManager: FirestoreManager
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
                        if email.isEmpty{
                            Text("")
                                .foregroundColor(.gray)
                        }
                        if password.isEmpty{
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
                                TextField("Email", text: $email)
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
                                SecureField("Password", text: $password)
                                    .background(Color.white.opacity(0.0).cornerRadius(100).frame(width:300, height: 50))
                                    .foregroundColor(.black)
                                    .font(.callout)
                                    .padding(.vertical,10)
                                    .frame(width: 300,height: 50)
                            }
                        }
                        Button (action: {
                            if(email=="Admin"&&password=="12345"){
                                admin=true
                                loggedin=false
                                nullinput = false
                                showalert = false
                                failedlogin = false
                                print("Admin logging in")
                            }
                            else{Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                                if email.isEmpty || password.isEmpty{
                                    nullinput = true
                                    showalert = true
                                    failedlogin = false
                                    loggedin = false
                                    admin = false
                                }
                                else if error != nil {
                                    print(error?.localizedDescription ?? "")
                                    failedlogin = true
                                    showalert = true
                                    nullinput = false
                                    loggedin = false
                                    admin = false
                                } else if error == nil {
                                    loggedin = true
                                    failedlogin = false
                                    showalert = false
                                    nullinput = false
                                    admin = false
                                    user = Auth.auth().currentUser?.email ?? ""
                                    print("Signed in: \(user)")
                                    UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
                                    UserDefaults.standard.synchronize()
                                }
                            }
                            }
                        }, label:{
                            Text("Sign In")
                        })
                        .padding()
                        .background(Color.white.opacity(0.8).cornerRadius(100).frame(width:80, height: 50))
                        .foregroundColor(.black)
                        .alert(isPresented: $showalert){
                            switch failedlogin{
                            case true:return Alert(title: Text("Unknown username/password"),message: Text("Please recheck your input or sign up if you're a new user"),dismissButton: .cancel(Text("OK")))
                            case false:return Alert(title: Text("Email/Password can't be blank"),message: Text("Please recheck your input or sign up if you're a new user"),dismissButton: .cancel(Text("OK")))
                            }
                        }
                        .navigationDestination(isPresented: $admin){
                            AdminView().navigationBarBackButtonHidden(true)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                        .navigationDestination(isPresented: $loggedin){
                            MainMenu().navigationBarBackButtonHidden(true)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                        HStack{
                            Button (action: {
                                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                                    if email.isEmpty || password.isEmpty{
                                        nullinput = true
                                        showalert2 = true
                                        failedsignup = false
                                    }
                                    else if error != nil {
                                        print(error?.localizedDescription ?? "")
                                        failedsignup = true
                                        showalert2 = true
                                        nullinput = false
                                    }
                                    else {
                                        loggedin = true
                                        user=email
                                    }
                                }
                            }, label:{
                                Text("New user? Sign Up")
                                    .foregroundColor(.black)
                                    .bold()

                            })
                            .padding()
                            .alert(isPresented: $showalert2){
                                switch failedsignup{
                                case true: return Alert(title: Text("User exists!"),message: Text("Please login using your existing account or press forgot password if you have forgotten your password "),dismissButton: .cancel(Text("OK")))
                                case false: return Alert(title: Text("Email/Password can't be blank"),message: Text("Please recheck your input or sign up if you're a new user"),dismissButton: .cancel(Text("OK")))
                                }
                            }
                            .navigationDestination(isPresented: $loggedin){
                                WelcomeScreen().navigationBarBackButtonHidden(true)
                                    .navigationBarTitleDisplayMode(.inline)
                            }
                            
                            Button (action: {
                                Auth.auth().sendPasswordReset(withEmail: email)
                                if email.isEmpty || password.isEmpty{
                                    nullinput = true
                                    forgotpassword = false
                                    showalert3 = true
                                }
                                else {
                                    forgotpassword = true
                                    nullinput = true
                                    showalert3 = true
                                }
                            }, label:{
                                Text("Forgot Password?")
                                    .foregroundColor(.black)
                                    .bold()

                            })
                            .padding()
                            .alert(isPresented: $showalert3){
                                switch forgotpassword{
                                case true: return Alert(title: Text("Request sent"),message: Text("Please check your email inbox to reset your password "),dismissButton: .cancel(Text("OK")))
                                case false: return Alert(title: Text("Email can't be blank"),message: Text("Please recheck your input or sign up if you're a new user"),dismissButton: .cancel(Text("OK")))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

/*struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}*/
