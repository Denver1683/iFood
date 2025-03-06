//
//  FilestoreManager.swift
//  MyFirebaseTestApp
//
//  Created by Denver Alfito Anggada on 15/11/2022.
//

import Foundation
import Firebase
var foodData: [Food] = []
var orderList: [AcceptOrder]=[]
class FirestoreManager: ObservableObject{
    @Published var restaurant: String = " "
    @Published var fl: [Food] = []
    init(){
        fetchFood()
        fetchOrder()
    }
    func changePassword(password:String){
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if let error = error{
                print("Change password failed: \(error)")
            }
        }
    }
    
    func fetchFood(){
        let db = Firestore.firestore()
        db.collection("/Restaurant/Menu/Food/").getDocuments{ snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        foodData = snapshot.documents.map{ data in
                            let cat = data["category"] as! String
                            var category = Categories.burger
                            if cat == "burger"{
                                category = Categories.burger
                            }
                            else if cat == "pizza"{
                                category = Categories.pizza
                            }
                            else if cat == "pasta"{
                                category = Categories.pasta
                            }
                            else if cat == "desserts"{
                                category = Categories.desserts
                            }
                            else{
                                category = Categories.drinks
                            }
                            return Food(title: data["name"] as? String ?? "" , price: data["price"] as? Double ?? 0.00, category: category, image: data["image"] as? String ?? "")
                        }
                    }
                }
            }
        }
    }
    
    func addMenu(foodname:String,price:Double,category:String,image:String){
        let db = Firestore.firestore()
        let ref = db.collection("/Restaurant/Menu/Food/").document(foodname)
        ref.setData(["category":category,"name":foodname,"price":price,"image":image]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                foodData=[]
                self.fetchFood()
            }
        }
    }
    
    func removeMenu(foodname:String){
        let db = Firestore.firestore()
        db.collection("/Restaurant/Menu/Food").whereField("name", isEqualTo: foodname).getDocuments{(snap,err) in
            if err != nil{
                print("Error")
                return
            }
            
            for i in snap!.documents{
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
            foodData=[]
            self.fetchFood()
        }
    }
    
    func ordertotal(cart:Cart)->Double{
        var total:Double=0.00
        let noi: Int = foodordered.count
        var i: Int = 0
        while i < noi{
            total = total + (cart.order[i].order.price * Double(cart.order[i].amount))
            i+=1
        }
        return total
    }
    
    func addOrder(cart:Cart){
        let db = Firestore.firestore()
        let uid = UUID().uuidString
        let ref = db.collection("/Restaurant/Order/iFood/").document(uid)
        var total:Double=0.00
        var orders: [String] = []
        var amount: [Int] = []
        //Number of items
        let noi: Int = foodordered.count
        var i: Int = 0
        while i < noi{
            orders.append(cart.order[i].order.title)
            amount.append(cart.order[i].amount)
            i+=1
        }
        total = ordertotal(cart: Cart(user: user,order: foodordered))
        ref.setData(["customer":cart.user,"order":orders,"amount":amount,"price":total,"id":uid]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                foodordered=[]
                self.fetchOrder()
            }
        }
    }
    
    func fetchOrder(){
        let db = Firestore.firestore()
        db.collection("/Restaurant/Order/iFood/").getDocuments{ snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        orderList = snapshot.documents.map{ data in
                            return AcceptOrder(user: data["customer"] as? String ?? "" , order: data["order"] as! [String], amount: data["amount"] as! [Int], id: data["id"] as! String, price: data["price"] as! Double)
                        }
                    }
                }
            }
        }
    }
    
    func removeOrder(orderID:String){
        let db = Firestore.firestore()
        db.collection("/Restaurant/Order/iFood").whereField("id", isEqualTo: orderID).getDocuments{(snap,err) in
            if err != nil{
                print("Error")
                return
            }
            
            for i in snap!.documents{
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
            orderList = []
            self.fetchOrder()
        }
    }
}

