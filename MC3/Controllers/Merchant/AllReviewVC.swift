//
//  AllReviewVC.swift
//  MC3
//
//  Created by Muhammad Thirafi on 24/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import FirebaseAuth

typealias CollectionDataSource = UICollectionViewDiffableDataSource<Sections,Review>
typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Sections,Review>

enum AllReviewSourceType {
    case user,merchant
}

class AllReviewVC: UIViewController {
    
    //MARK: - Properties
    private var ViewDataSource: CollectionDataSource?
    private var ViewSnapshot:CollectionSnapshot?
    
    var merchantID: String?
    var userID: String?
    
    var allReviewsFor: AllReviewSourceType? {
        didSet {
            configAllneededforCV()
            guard let allreviewType = allReviewsFor else {return}
            self.fetchReviews(reviewsFor: allreviewType)
            
            if allreviewType == .merchant {
                title = "Merchant's Reviews"
            } else {
                title = "All Reviews"
            }
        }
    }
    
    private var reviews: [Review] = [Review]() {
        didSet {
             
            self.updateSnapshot(data: self.reviews)
        }
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "Add Review", titleColor: .black, backgroundColor: UIColor(hexString: "9CE4E5"), cornerRadius: 8)
        button.setSize(width: 170, height: 50)
        button.addTarget(self, action: #selector(addButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureReviewCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(ReviewCollectionViewCells.self, forCellWithReuseIdentifier: ReviewCollectionViewCells.identifier)
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI(){
        view.backgroundColor = .white
    
        self.view.addSubview(collectionView) {
            self.collectionView.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.rightAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, left: self.view.leftAnchor)
        }
        
        view.addSubview(addButton){
            self.addButton.setCenterXAnchor(in: self.view)
            self.addButton.setAnchor( bottom: self.view.bottomAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 25, paddingLeft: 8)
        }
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        addButton.isHidden = Auth.auth().currentUser != nil ? false : true
    }
    
    private func configAllneededforCV(){
        configDataSource()
        configSnapshot()
    }
    
    private func configDataSource(){
        ViewDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionview, indexPath, review) -> UICollectionViewCell? in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCells.identifier, for: indexPath) as? ReviewCollectionViewCells else {return UICollectionViewCell()}
            cell.details = review
            cell.configureCells()
            return cell
        }
    }
    
    private func configSnapshot() {
        ViewSnapshot = CollectionSnapshot()
        ViewSnapshot!.appendSections([.main])
        ViewDataSource?.apply(ViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func updateSnapshot(data: [Review]) {
        ViewSnapshot!.appendItems(data, toSection: .main)
        ViewDataSource!.apply(ViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func fetchReviews(reviewsFor type: AllReviewSourceType) {
        switch type {
            case .merchant:
                self.fetchReviewsForMerchants()
            case .user:
                self.fetchReviewsForUser()
        }
    }
    
    private func fetchReviewsForMerchants() {
        guard let merchantID = self.merchantID else {return}
        FirebaseService.shared.fetchMerchantReviews(merchantID: merchantID) { (review, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    guard let review = review else {return}
                    self.reviews.append(review)
                }
            }
        }
    }
    
    private func fetchReviewsForUser() {
        guard let userID = self.userID else {return}
        FirebaseService.shared.fetchUserReviews(userID: userID) { (review, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    guard let review = review else {return}
                    self.reviews.append(review)
                }
            }
        }
    }

    
    @objc func addButtonDidTapped(_ Button: UIButton){
        let addReviewVC = AddReviewViewController()
        addReviewVC.merchantID = self.merchantID
        self.navigationController?.pushViewController(addReviewVC, animated: true)
    }
    
}

extension AllReviewVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = ViewDataSource?.itemIdentifier(for: indexPath)
//            print("SELECTED Review : \(review!.userName)")
        }
}
