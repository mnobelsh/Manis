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
let STORAGE_REF = Storage.storage()
let REVIEWS_IMAGE_REF = STORAGE_REF.reference(withPath: "reviews")
let USERS_IMAGE_REF = STORAGE_REF.reference(withPath: "users")
let MERCHANT_IMAGE_REF = STORAGE_REF.reference(withPath: "merchants")
let USER_REF = DB_REF.collection("users")
let MERCHANT_REF = DB_REF.collection("merchants")
let GEOFIRE_REF = DB_REF.collection("merchant_locations")
let REVIEW_REF = DB_REF.collection("reviews")

struct FirebaseService {
    
    static let shared = FirebaseService()
    let geofireStore = GeoFirestore(collectionRef: GEOFIRE_REF)
    
    
    private func getMerchantModel(snapshotData data: [String:Any], completion: @escaping(Merchant) -> Void ) {
        guard let merchantID = data[Merchant.merchantIDField] as? String else {return}
        guard let address = data[Merchant.addressField] as? String else {return}
        guard let name = data[Merchant.nameField] as? String else {return}
        guard let lovedBy = data[Merchant.lovedByField] as? Int else {return}
        guard let menu = data[Merchant.menuField] as? [[String:Any]] else {return}
        guard let badge = data[Merchant.badgeField] as? [String:Any] else {return}
        guard let phoneNumber = data[Merchant.phoneNumberField] as? String else {return}
        guard let rating = data[Merchant.ratingField] as? Double else {return}
        

        let greatTasteBadge = Badge(type: .greatTaste, count: badge[String(BadgeType.greatTaste.rawValue)] as! Int)
        let cleanToolsBadge = Badge(type: .cleanTools, count: badge[String(BadgeType.cleanTools.rawValue)] as! Int)
        let cleanIngredientsBadge = Badge(type: .cleanIngredients, count: badge[String(BadgeType.cleanIngredients.rawValue)] as! Int)
        
        
        var merchantMenu = [Menu]()

        menu.forEach { (m) in
            guard let title = m[Menu.titleField] as? String else {return}
            guard let price = m[Menu.priceField] as? Double else {return}
            merchantMenu.append(Menu(title: title, price: price))
        }
        
        fetchMerchantLocation(merchantID: merchantID) { (location) in
            let merchant = Merchant(id: merchantID, name: name, address: address, lovedBy: lovedBy, menu: merchantMenu, badges: [greatTasteBadge,cleanToolsBadge,cleanIngredientsBadge], phoneNumber: phoneNumber, rating: rating, location: location)
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
    
    func fetchHighRatingMerchants(limitMerchants limit: Int? = nil, completion: @escaping(Merchant?,Error?) -> Void) {
        let lim: Int = limit == nil ? .max : limit!
        MERCHANT_REF.order(by: Merchant.ratingField, descending: true).limit(to: lim).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                completion(nil,err)
            } else {
                guard let documents = querySnapshot?.documents else {return}
                documents.forEach { (document) in
                    var data = document.data()
                    data[Merchant.merchantIDField] = document.documentID
                    self.getMerchantModel(snapshotData: data) { (merchant) in
                        var m = merchant
                        m.section = .rating
                        completion(m,nil)
                    }
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
    
    func addReview(data: [String:Any], completion: @escaping(Error?) -> Void) {
        REVIEW_REF.addDocument(data: data) { (error) in
            if let err = error {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    func updateMerchantData(merchantID: String, data: [String:Any], completion: @escaping(Error?) -> Void) {
        MERCHANT_REF.document(merchantID).updateData(data) { (error) in
            if let err = error {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    
    private func getReviewModel(data: [String:Any], completion: @escaping(Review) ->Void) {

        print("FETCH 1")
        guard let userID = data[Review.userIDField] as? String else {return}
        guard let merchantID = data[Review.merchantIDField] as? String else {return}
        guard let rating = data[Review.ratingField] as? Double else {return}
        guard let details = data[Review.detailsField] as? String else {return}
        guard let reviewID = data[Review.reviewIDField] as? String else {return}
        guard let badge = data[Merchant.badgeField] as? [String:Any] else {return}
        
        
        let greatTasteBadge = Badge(type: .greatTaste, count: badge[String(BadgeType.greatTaste.rawValue)] as! Int)
        let cleanToolsBadge = Badge(type: .cleanTools, count: badge[String(BadgeType.cleanTools.rawValue)] as! Int)
        let cleanIngredientsBadge = Badge(type: .cleanIngredients, count: badge[String(BadgeType.cleanIngredients.rawValue)] as! Int)
         
        
        let review = Review(id: reviewID, userID: userID, merchantID: merchantID, rating: rating, badges: [greatTasteBadge,cleanToolsBadge,cleanIngredientsBadge], details: details)
        completion(review)
    }
    
    func fetchReview(reviewID: String, completion: @escaping(Review?,Error?) -> Void) {
        REVIEW_REF.document(reviewID).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                completion(nil,err)
            } else {
                if let snapshot = querySnapshot {
                    guard let data = snapshot.data() else {return}
                    var reviewData = data
                    reviewData[Review.reviewIDField] = snapshot.documentID
                    self.getReviewModel(data: data) { (review) in
                        completion(review,nil)
                    }
                }
            }
        }
    }
    
    func fetchMerchantReviews(merchantID: String, withLimit limit: Int? = nil, completion: @escaping(Review?,Error?) -> Void) {
        let lim: Int = limit == nil ? .max : limit!
        REVIEW_REF.whereField(Review.merchantIDField, isEqualTo: merchantID).limit(to: lim).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                completion(nil,err)
            } else {
                guard let dataCollection = querySnapshot?.documents else {return}
                dataCollection.forEach { (dataSnapshot) in
                    var reviewData = dataSnapshot.data()
                    reviewData[Review.reviewIDField] = dataSnapshot.documentID
                    self.getReviewModel(data: reviewData) { (review) in
                        completion(review,nil)
                    }
                }
            }
        }
    }
    
    func fetchUserReviews(userID: String, completion: @escaping(Review?,Error?) -> Void) {
        REVIEW_REF.whereField(Review.userIDField, isEqualTo: userID).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                completion(nil,err)
            } else {
                guard let dataCollection = querySnapshot?.documents else {return}
                dataCollection.forEach { (dataSnapshot) in
                    var reviewData = dataSnapshot.data()
                    print("REVIEW USER FETCH : \(reviewData)")
                    reviewData[Review.reviewIDField] = dataSnapshot.documentID
                    self.getReviewModel(data: reviewData) { (review) in
                        completion(review,nil)
                    }
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
            guard let favorites = data[User.favoritesField] as? [String] else {return}

            
            let user = User(id: userID, email: email, name: name, profilePicture: profilePicture, favorites: favorites)
            completion(user)
        }
    }
    
    private func addUser(user: [String:Any], completion: @escaping(Error?)->Void) {
        guard let userID = user[User.userIDField] as? String else {return}
        USER_REF.document(userID).setData(user) { (error) in
            if let err = error {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    func addMerchant(merchantData: [String: Any], completion: @escaping() -> Void) {

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
    
    func registerUser(userData: [String:Any],completion: @escaping([String:Any]?,Error?) -> Void) {
        guard let email = userData[User.emailField] as? String else {return}
        guard let password = userData[User.passwordField] as? String else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let err = error {
                completion(nil,err)
            } else  {
                var data = userData
                data[User.userIDField] = result!.user.uid
                data.removeValue(forKey: User.passwordField)
                self.addUser(user: data) { (error) in
                    if let err = error {
                        completion(nil,err)
                    } else {
                        completion(data,nil)
                    }
                }
            }
            
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping(User?,Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
            if let err = error {
                completion(nil,err)
                return
            }
            
            guard let userID = result?.user.uid else {return}
            self.fetchUser(userID: userID) { (user) in
                completion(user,nil)
            }
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
    
    func uploadUserProfileImage(forUserID userID: String, withImageData imageData: Data, completion: @escaping(Error?) -> Void ) {
        
        let ref = USERS_IMAGE_REF.child(userID).child("profile.png")

        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        
        ref.putData(imageData, metadata: metaData) { (storageMetaData, error) in
            if let err = error {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    func downloadUserProfileImage(forUserID userID: String, completion: @escaping(UIImage?,Error?) -> Void) {
        let ref = USERS_IMAGE_REF.child(userID).child("profile.png")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let err = error {
            completion(nil,err)
          } else {
            let image = UIImage(data: data!)
            completion(image,nil)
          }
        }
        
    }
    
    func downloadMerchantPhotos(forMerchantID merchantID: String, completion: @escaping(UIImage?,Error?) -> Void) {
        
        let ref = MERCHANT_IMAGE_REF.child(merchantID).child("photo1.jpg")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let err = error {
            completion(nil,err)
          } else {
            let image = UIImage(data: data!)
            completion(image,nil)
          }
        }

        
    }
    
    func fetchUserFavourites(userID: String, completion: @escaping(Merchant?,Error?) -> Void) {
        USER_REF.document(userID).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                completion(nil,err)
            } else {
                if let snapshot = querySnapshot?.data() {
                    guard let merchantID = snapshot[User.favoritesField] as? [String] else {return}
                    merchantID.forEach { (id) in
                        self.fetchMerchant(merchantID: id) { (merchant) in
                            completion(merchant,nil)
                        }
                    }
                }
            }
        }
    }

    
}
