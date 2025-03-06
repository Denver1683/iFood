# 🍽️ iFood - iOS Dine-In Ordering System

### 📌 Developed by: Denver Alfito Anggada  
### 📱 Module: iOS Mobile App Development  

## 🔰 Introduction
**iFood** is an iOS mobile application designed for a **fast-food restaurant in Kuala Lumpur, Malaysia**. The app streamlines the dine-in ordering process, reducing physical contact, minimizing paper waste, and enhancing efficiency for both **customers and restaurant staff**.

- **Platform:** iOS 16 and above  
- **Target Users:** Customers & restaurant staff  
- **Data Storage:** Firebase (**requires manual configuration**)  
- **Development Approach:** Swift, Object-Oriented Programming (OOP) principles  

---

## 🛠️ Features
### **For Customers**
✅ **Login & Sign Up** – Secure authentication using email & password  
✅ **Menu Browsing** – Browse food categories & item details  
✅ **Add to Cart** – Select items & modify quantities before ordering  
✅ **Order Submission** – Orders are stored in Firebase  
✅ **View Account Details** – Update user information & change passwords  
✅ **Persistent Login** – Remembers user credentials for quick access  

### **For Admin/Staff**
✅ **Admin Dashboard** – Manage menu & orders  
✅ **Add/Edit/Delete Menu** – Update food items dynamically  
✅ **Order Management** – View & mark orders as completed after payment  

---

## 🚀 Installation Guide
### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/Denver1683/iFood.git
cd iFood
```

### **2️⃣ Open the Project**
- Open **iFood.xcodeproj** in Xcode (ensure Xcode 14+ is installed).

### **3️⃣ Install Dependencies**
```sh
pod install
```
- After installing pods, open **iFood.xcworkspace** instead of **.xcodeproj**.

### **4️⃣ Configure Firebase (Required)**
Firebase is required for **authentication & data storage**.
1. Go to **[Firebase Console](https://console.firebase.google.com/)**.
2. Create a **new project**.
3. Add an **iOS app** → Enter the **Bundle Identifier** (found in Xcode under **Signing & Capabilities**).
4. Download `GoogleService-Info.plist`.
5. Move `GoogleService-Info.plist` to the **iFood project root directory**.
6. Install Firebase SDK:
   ```sh
   pod install
   ```
7. Enable **Authentication (Email & Password)** and **Firestore Database** in Firebase Console.

---

## ❗ Known Limitations
🔴 **Manual Payment** – The app does not support online payment integration (manual cash/card payment required).  
🔴 **Non-Realtime Database** – Menu updates require an app refresh to reflect changes.  
🔴 **Offline Cart** – Cart data is stored locally and resets when the app is restarted.  

---

## 🏗️ Future Enhancements
✔ **Integrate Online Payment** (Stripe/Apple Pay)  
✔ **Enable Real-Time Updates** in Firestore  
✔ **Implement Push Notifications** for Order Updates  

---

## 📄 License
This project is **for educational purposes and my personal portfolio only**. Unauthorized redistribution or commercial use is strictly prohibited.

🚀 **Happy Coding!**

