//
//  FirebaseService.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import Foundation
import Firebase
import Geofirestore
import CoreLocation

let DB_REF = Firestore.firestore()
let USER_REF = DB_REF.collection("users")
let MERCHANT_REF = DB_REF.collection("merchants")
let GEOFIRE_REF = DB_REF.collection("merchant_locations")

struct FirebaseService {
    
    static let shared = FirebaseService()
    let geofireStore = GeoFirestore(collectionRef: GEOFIRE_REF)
    
    func fetchMerchant(merchantID: String, completion: @escaping(Merchant) -> Void ) {
        MERCHANT_REF.document(merchantID).addSnapshotListener { (snapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else {return}
            guard let address = data[Merchant.address] as? String else {return}
            guard let name = data[Merchant.name] as? String else {return}
            guard let lovedCount = data[Merchant.lovedCount] as? Int else {return}
            
            var merchantMenu = [Menu]()
            if let menus = data[Merchant.menu] as? [[String:Any]] {
                menus.forEach { (menu) in
                    guard let title = menu[Menu.titleField] as? String else {return}
                    guard let price = menu[Menu.priceField] as? Double else {return}
                    let m = Menu(title: title, price: price)
                    merchantMenu.append(m)
                }
            } else {
                merchantMenu = []
            }

            let merchant = Merchant(id: merchantID, name: name, address: address, lovedCount: lovedCount, menu: merchantMenu)
            
            completion(merchant)
            
        }
    }
    
    func fetchMerchantLocation(merchantID: String, completion: @escaping(CLLocation) -> Void ) {
        
    }
    
    func fetchUser(userID: String, completion: @escaping(User) -> Void ) {
        USER_REF.document(userID).addSnapshotListener { (snapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else {return}
            guard let email = data[User.emailField] as? String else {return}
            guard let name = data[User.nameField] as? String else {return}
            guard let profilePicture = data[User.profilePicture] as? String else {return}
            
            let user = User(id: userID, email: email, name: name, profilePicture: profilePicture, reviews: [], favorites: [])
            
            completion(user)
        }
    }
    
    private func addUser(user: [String:Any], completion: (() -> Void)?) {
        guard let userID = user[User.userIDField] as? String else {return}
        USER_REF.document(userID).setData(user) { (error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            if let completion = completion {
                completion()
            }
        }
    }
    
    func registerMerchant(merchantData: [String: Any], completion: @escaping() -> Void) {
        guard let merchantName = merchantData[Merchant.name] as? String else {return}
        let uuid = UUID().uuidString.split(separator: Character("-")).last!
        let merchantID = merchantName.trimmingCharacters(in: .whitespacesAndNewlines) + uuid
        
        MERCHANT_REF.document(merchantID).setData(merchantData) { (error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            completion()
        }
    }
    
    func registerUser(userData: [String:Any],completion: @escaping() -> Void) {
        guard let email = userData[User.emailField] as? String else {return}
        guard let password = userData[User.passwordField] as? String else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            var data = userData
            data[User.userIDField] = result!.user.uid
            data.removeValue(forKey: User.passwordField)
            self.addUser(user: data) {
                completion()
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping(User) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            guard let userID = result?.user.uid else {return}
            guard let email = result?.user.email else {return}
            let user = User(id: userID, email: email, name: "User", profilePicture: "profile", reviews: [], favorites: [])
            completion(user)
        }
    }
    
    func signOut(completion: @escaping()->Void) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchNearbyMerchants(location: CLLocation, withRadius radius: Double, completion: @escaping(Merchant)->Void) {
        let _ = geofireStore.query(withCenter: location, radius: radius).observe(.documentEntered) { (merchantID, location) in
            
            self.fetchMerchant(merchantID: merchantID!) { (merchant) in
                completion(merchant)
            }
            
        }
    }
    
    
}
