//
//  MerchantViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseAuth

class MerchantViewController: UIViewController {
    
    // MARK: - Properties
    private var checkDataSource: CollectionDataSource?
    private var checkSnapshot:CollectionSnapshot?
    
    // MARK: - Properties
    var merchant: Merchant? {
        didSet {
            addressLabel.text = merchant?.address
            let priceMin = merchant!.menu.map { Int($0.price) }.min()
            let priceMax = merchant!.menu.map { Int($0.price) }.max()
            let priceMinStr = self.priceFormatter(price: priceMin ?? 0)
            let priceMaxStr = self.priceFormatter(price: priceMax ?? 0)
            if priceMin! == priceMax! {
                priceRange.text = priceMinStr
            } else {
                priceRange.text = "\(priceMinStr) - \(priceMaxStr)"
            }
            
            var badgesList = [Badge]()
            merchant!.badges.forEach({ (badge) in
                if badge.count > 0 {
                    badgesList.append(badge)
                }
            })
            
            self.badges = badgesList

        }
    }
    var user: User?
    
    private var badges: [Badge] = [Badge]() {
        didSet {
            self.badgeCollectionView.reloadData()
        }
    }
    private var photos: [UIImage] = [#imageLiteral(resourceName: "default no photo")] {
        didSet {
            self.photoCollectionView.reloadData()
        }
    }
    
    private lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Merchant Address", fontSize: 16, textColor: .darkGray)
        return label
    }()
    
    private lazy var headerView: MerchantHeaderView = {
        let header = MerchantHeaderView(frame: .init(x: 0, y: -MerchantHeaderView.height, width: self.view.frame.width, height: MerchantHeaderView.height))
        header.delegate = self
        return header
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = self.view.bounds
        scrollV.contentInset = .zero
        scrollV.automaticallyAdjustsScrollIndicatorInsets = false
        scrollV.contentSize = CGSize(width: self.view.frame.width, height: 1870)
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.alwaysBounceVertical = false

        return scrollV
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Price Range", fontSize: 20, textColor: .black)
        return label
    }()
    private lazy var priceRange: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Rp. 0", fontSize: 12, textColor: .black)
        return label
    }()
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Badges", fontSize: 20, textColor: .black)
        return label
    }()
    
    

    private lazy var badgeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 9, bottom: .zero, right: 8)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MerchantPropertiesCollectionViewCell.self, forCellWithReuseIdentifier: MerchantPropertiesCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self

        return cv
    }()

    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Menu", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var stackMenu: UIStackView = {
        var stacksArr = [UIStackView]()
        
        if merchant!.menu.count > 0 {
            for menu in merchant!.menu {
                let menuLabel = UILabel()
                menuLabel.configureTextLabel(title: menu.title, fontSize: 12, textColor: .black)
                let priceLabel = UILabel()
                priceLabel.setSize(width: 80)
                priceLabel.configureTextLabel(title: priceFormatter(price: Int(menu.price)), fontSize: 12, textColor: .black)

                let stack = UIStackView(arrangedSubviews: [menuLabel, priceLabel])
                stack.axis = .horizontal
                stack.distribution = .fillProportionally
                
                stacksArr.append(stack)
            }
        } else {
            let menuLabel = UILabel()
            menuLabel.configureTextLabel(title: "Menu is not available", fontSize: 14, textColor: .darkGray)
            let stack1 = UIStackView(arrangedSubviews: [menuLabel])
            stack1.alignment = .center
            stacksArr.append(stack1)
        }

        let stack = UIStackView(arrangedSubviews: stacksArr)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        return stack
    }()

    private lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let height: CGFloat = CGFloat(20 + (20 * merchant!.menu.count))
        view.setSize( height: height)
        view.configureShadow(shadowColor: .lightGray, radius: 3)
        view.configureRoundedCorners(corners: [.allCorners], radius: 8)
        return view
    }()

    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Photos", fontSize: 20, textColor: .black)
        return label
    }()

    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 8)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MerchantPropertiesCollectionViewCell.self, forCellWithReuseIdentifier: MerchantPropertiesCollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Reviews", fontSize: 20, textColor: .black)
        return label
    }()
    
    private lazy var seeAllReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(seeAllReviewButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private var reviews: [Review] = [Review]() {
        didSet {
            self.updateSnapshot(self.reviews)
        }
    }

    private lazy var collectionViewReview: UICollectionView = {
        let collectionViewReview = UICollectionView(frame: .zero, collectionViewLayout: configureReviewCollectionViewLayout())
        collectionViewReview.backgroundColor = .clear
        collectionViewReview.delegate = self
        collectionViewReview.isScrollEnabled = false
        collectionViewReview.register(ReviewCollectionViewCells.self, forCellWithReuseIdentifier: ReviewCollectionViewCells.identifier)
        return collectionViewReview
    }()
    



    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTransparentNavbar()
        configDatasource()
        configSnapshot()
        
        
        if let userID = Auth.auth().currentUser?.uid {
            FirebaseService.shared.fetchUser(userID: userID) { (user) in
                self.user = user
                self.headerView.configureComponents(merchant: self.merchant!, userFavs: self.user?.favorites)
            }
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        fetchMerchantReviews { (review) in
            DispatchQueue.main.async {
                self.reviews.append(review)
            }
        }
        
        var merchPhoto = [UIImage]()
        FirebaseService.shared.downloadMerchantPhotos(forMerchantID: merchant!.id) { (image, error) in
            DispatchQueue.main.async {
                guard let image = image else {return}
                merchPhoto.append(image)
                self.photos = merchPhoto
            }
        }
        configUI()
        UIView.animate(withDuration: 0.35) {
            self.headerView.frame.origin.y = 0
        }
    }

    // MARK: - Helpers
    private func fetchMerchantReviews(completion: @escaping(Review) -> Void) {
        FirebaseService.shared.fetchMerchantReviews(merchantID: merchant!.id, withLimit: 3, completion: { (review, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                guard let rev = review else {return}
                completion(rev)
            }
        })
    }
    
    func configUI(){
        self.view.addSubview(self.headerView)
        self.view.addSubview(scrollView){
            self.scrollView.setAnchor(top: self.view.topAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor)
        }

        self.scrollView.addSubview(headerView){
            self.headerView.setAnchor(top: self.scrollView.topAnchor, right: self.view.rightAnchor,left: self.view.leftAnchor)
            self.headerView.setSize(height: 261)
        }

        self.scrollView.addSubview(priceLabel){
            self.priceLabel.setAnchor(top: self.headerView.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 12, paddingRight: 8, paddingBottom: 8, paddingLeft: 16)
            self.priceLabel.setSize(height: 30)
        }

        self.scrollView.addSubview(priceRange){
            self.priceRange.setAnchor(top: self.priceLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: 4, paddingRight: 8, paddingBottom: 8, paddingLeft: 16)
        }

        self.scrollView.addSubview(badgeLabel){
            self.badgeLabel.setAnchor(top: self.priceRange.bottomAnchor, left: self.view.leftAnchor, paddingTop: 12, paddingRight: 8, paddingBottom: 6, paddingLeft: 16)
        }
        
        
        self.scrollView.addSubview(badgeCollectionView){
            self.badgeCollectionView.setAnchor(top: self.badgeLabel.bottomAnchor,right: self.view.rightAnchor, left: self.view.leftAnchor)
            self.badgeCollectionView.backgroundColor = .clear
            self.badgeCollectionView.heightAnchor.constraint(equalTo: self.badgeCollectionView.widthAnchor, multiplier: 0.3).isActive = true
        }

        self.scrollView.addSubview(menuLabel){
            self.menuLabel.setAnchor(top: self.badgeCollectionView.bottomAnchor, left: self.view.leftAnchor, paddingTop: 12, paddingRight: 8, paddingBottom: 8, paddingLeft: 16)
        }

        self.scrollView.addSubview(menuView){
            self.menuView.setAnchor(top: self.menuLabel.bottomAnchor, right:self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 4, paddingRight: 16, paddingLeft: 16)
            self.menuView.addSubview(self.stackMenu){
                self.stackMenu.setAnchor(top: self.menuView.topAnchor, right: self.menuView.rightAnchor, bottom: self.menuView.bottomAnchor, left: self.menuView.leftAnchor, paddingTop: 8, paddingLeft: 8)
            }
        }

        self.scrollView.addSubview(photoLabel){
            self.photoLabel.setAnchor(top: self.menuView.bottomAnchor, left: self.view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        }
        
        self.scrollView.addSubview(photoCollectionView){
            self.photoCollectionView.setAnchor(top: self.photoLabel.bottomAnchor,right: self.view.rightAnchor, left: self.photoLabel.leftAnchor)
            self.photoCollectionView.setSize(height: 135)
            self.photoCollectionView.backgroundColor = .clear
        }

        self.scrollView.addSubview(reviewLabel){
            self.reviewLabel.setAnchor(top: self.photoCollectionView.bottomAnchor, left: self.view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        }
        
        //HERE
        self.scrollView.addSubview(seeAllReviewButton) {
            self.seeAllReviewButton.setAnchor(top: self.reviewLabel.topAnchor, right: self.photoCollectionView.rightAnchor, bottom: self.reviewLabel.bottomAnchor, paddingRight: 8)
            self.seeAllReviewButton.setSize(width: 100)
        }
        
        self.scrollView.addSubview(collectionViewReview){
            self.collectionViewReview.setAnchor(top: self.reviewLabel.bottomAnchor ,right: self.view.rightAnchor, bottom: self.scrollView.bottomAnchor,left: self.view.leftAnchor)
            self.collectionViewReview.setSize( height: 1005)
        }
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
    }

    private func configDatasource(){
        checkDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionViewReview) { (collectionV, indexPath, review) -> UICollectionViewCell? in
            guard let cell = collectionV.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCells.identifier, for: indexPath) as? ReviewCollectionViewCells else {return UICollectionViewCell()}
            cell.details = review
            cell.configureCells()
            return cell
        }
    }
    
    private func configSnapshot(){
        checkSnapshot = CollectionSnapshot()
        checkSnapshot!.appendSections([.main])
        checkDataSource!.apply(checkSnapshot!, animatingDifferences: true, completion: nil)
    }

    private func updateSnapshot(_ data: [Review]) {
        checkSnapshot!.appendItems(data, toSection: .main)
        checkDataSource!.apply(checkSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func priceFormatter(price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: price as NSNumber) {
           return "Rp " + formattedTipAmount
        }
        return "Rp 0"
    }
    
    // MARK: - Targets
    @objc private func seeAllReviewButtonDidTap() {
        let allReviewVC = AllReviewVC()
        allReviewVC.addButton.isHidden = false
        allReviewVC.merchantID = merchant!.id
        allReviewVC.allReviewsFor = .merchant
        self.navigationController?.pushViewController(allReviewVC, animated: true)
    }

}

// MARK: - Collection View Delegate
extension MerchantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let merchantReview = checkDataSource?.itemIdentifier(for: indexPath)
//        print("DEBUGS Merchant Review : \(merchantReview!.userName)")
    }
}

//MARK: - Main Header View Delegate
extension MerchantViewController: MerchantHeaderViewDelegate {
    func favDidTapped(_ button: UIButton) {
        guard let merchantID = merchant?.id else {return}
        guard let user = self.user else {return}
        
        
        var userFavs = [String]()
        if button.isSelected {
            userFavs = user.favorites
            if !userFavs.contains(merchantID) {
              userFavs.append(merchantID)
            }
        } else {
            userFavs = user.favorites.filter({ (id) -> Bool in
                return id != merchantID
            })
        }
        
        FirebaseService.shared.updateUserFavorites(userID: user.id, favorites: userFavs) { (error) in
            
        }

    }
    
    func backButtView() {

    }

}

extension MerchantViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == badgeCollectionView {
            return badges.count
        } else if collectionView == photoCollectionView {
            return photos.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MerchantPropertiesCollectionViewCell.identifier, for: indexPath) as! MerchantPropertiesCollectionViewCell

        if collectionView == badgeCollectionView{
            cell.badgeData = badges[indexPath.row]
            cell.configBadgeCV()
            return cell
        } else if collectionView == photoCollectionView {
            cell.photoData = photos[indexPath.row]
            cell.configPhotoCV()
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == badgeCollectionView {
            return CGSize(width: 84 , height: 106)
        }
        return CGSize(width: 135, height: 135)
    }

}
