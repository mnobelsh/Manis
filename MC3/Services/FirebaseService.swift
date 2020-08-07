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
    
    private func getMerchantModel(snapshotData data: [String:Any], completion: @escaping(Merchant) -> Void ) {
        guard let merchantID = data[Merchant.merchantIDField] as? String else {return}
        guard let address = data[Merchant.addressField] as? String else {return}
        guard let name = data[Merchant.nameField] as? String else {return}
        guard let lovedBy = data[Merchant.lovedByField] as? Int else {return}
        guard let menu = data[Merchant.menuField] as? [[String:Any]] else {return}
        guard let badge = data[Merchant.badgeField] as? [[String:Any]] else {return}
        guard let phoneNumber = data[Merchant.phoneNumberField] as? String else {return}
        guard let rating = data[Merchant.ratingField] as? Double else {return}
        
        var merchantMenu = [Menu]()
        var badges = [Badge]()
        
        badge.forEach { (b) in
            guard let type = b[Badge.typeField] as? Int else {return}
            guard let count = b[Badge.countField] as? Int else {return}
            badges.append(Badge(type: BadgeType(rawValue: type)!, count: count))
        }
        
        menu.forEach { (m) in
            guard let title = m[Menu.titleField] as? String else {return}
            guard let price = m[Menu.priceField] as? Double else {return}
            merchantMenu.append(Menu(title: title, price: price))
        }
        
        fetchMerchantLocation(merchantID: merchantID) { (location) in
            let merchant = Merchant(id: merchantID, name: name, address: address, lovedBy: lovedBy, menu: merchantMenu, badges: badges, phoneNumber: phoneNumber, rating: rating, location: location)
            completion(merchant)
        }
    }
    
    private func fetchMerchantLocation(merchantID: String, completion: @escaping(CLLocation) -> Void ) {
        GEOFIRE_REF.document(merchantID).addSnapshotListener { (documentSnapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            guard let data = documentSnapshot?.data() else {return}
            guard let location = data["l"] as? [CLLocationDegrees] else {return}
            guard let lat = location.first else {return}
            guard let lon = location.last else {return}
        
            let loc = CLLocation(latitude: lat, longitude: lon)
            completion(loc)
        }
    }
    
    func fetchMerchant(merchantID: String, completion: @escaping(Merchant) -> Void ) {
        MERCHANT_REF.document(merchantID).addSnapshotListener { (snapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else {return}
            var snapshotData = data
            snapshotData[Merchant.merchantIDField] = merchantID
            self.getMerchantModel(snapshotData: snapshotData) { (merchant) in
                completion(merchant)
            }
        }
    }
    
    func fetchNearbyMerchants(location: CLLocation, withRadius radius: Double, completion: @escaping(Merchant,CLLocation)->Void) {
        let _ = geofireStore.query(withCenter: location, radius: radius).observe(.documentEntered) { (merchantID, location) in
            self.fetchMerchant(merchantID: merchantID!) { (merchant) in
                var m = merchant
                m.section = .nearby
                completion(m, location!)
            }
        }
    }
    
    func fetchHighRatingMerchants(limitMerchants limit: Int? = nil, completion: @escaping(Merchant) -> Void) {
        let lim: Int = limit == nil ? .max : limit!
        MERCHANT_REF.order(by: Merchant.ratingField, descending: true).limit(to: lim).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else {return}
            documents.forEach { (document) in
                var data = document.data()
                data[Merchant.merchantIDField] = document.documentID
                self.getMerchantModel(snapshotData: data) { (merchant) in
                    var m = merchant
                    m.section = .rating
                    completion(m)
                }
            }
        }
    }
    
    func fetchTrendingMerchants(limitMerchants limit: Int? = nil, completion: @escaping(Merchant) -> Void) {
        let lim: Int = limit == nil ? .max : limit!
        MERCHANT_REF.order(by: Merchant.lovedByField, descending: true).limit(to: lim).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else {return}
            documents.forEach { (document) in
                var data = document.data()
                data[Merchant.merchantIDField] = document.documentID
                self.getMerchantModel(snapshotData: data) { (merchant) in
                    var m = merchant
                    m.section = .trendings
                    completion(m)
                }
            }
        }
    }
    
    func fetchMerchants(completion: @escaping(Merchant) -> Void) {
        MERCHANT_REF.addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else {return}
            documents.forEach { (document) in
                var data = document.data()
                data[Merchant.merchantIDField] = document.documentID
                self.getMerchantModel(snapshotData: data) { (merchant) in
                    completion(merchant)
                }
            }
        }
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
            guard let profilePicture = data[User.profilePictureField] as? String else {return}
            
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

        let merchantID = "\(UUID().uuidString.split(separator: Character("-")).last!)"
        guard let location = merchantData[Merchant.locationField] as? CLLocation else {return}
        
        var data = merchantData
        data.removeValue(forKey: Merchant.locationField)
        MERCHANT_REF.document(merchantID).setData(data) { (error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            self.geofireStore.setLocation(location: location, forDocumentWithID: merchantID) { (error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                completion()
            }
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

    
}
