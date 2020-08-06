//
//  MerchantViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

class MerchantViewController: UIViewController {
    
    var merchant: Merchant? {
        didSet {
            merchantNameLabel.text = merchant?.name
            addressLabel.text = merchant?.address
        }
    }
    
     private var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant Name", fontSize: 20, textColor: .black)
        return label
    }()
     private var addressLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Merchant Address", fontSize: 16, textColor: .darkGray)
        return label
    }()

    private var checkDataSource: CollectionDataSource?
    private var checkSnapshot:CollectionSnapshot?

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
        label.configureTextLabel(title: "Rp10.000 - Rp15.000", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Badges", fontSize: 20, textColor: .black)
        return label
    }()

    //MARK: - CV Badge
    lazy var badgeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 9, bottom: .zero, right: 8)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self

        return cv
    }()

    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Menu", fontSize: 20, textColor: .black)
        return label
    }()

    private lazy var menu1: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "es cendol", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var menu2: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "es cendol + Jelly", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var menu3: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "es cendol ++", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var harga1: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Rp 10.000", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var harga2: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Rp 15.000", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var harga3: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Rp 18.000", fontSize: 12, textColor: .black)
        return label
    }()

    private lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setSize( height: 80)
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
        cv.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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

    //MARK: - CollectionView Review
    private lazy var collectionViewReview: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configureReviewCollectionViewLayout())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.isScrollEnabled = false
        cv.register(ReviewCollectionViewCells.self, forCellWithReuseIdentifier: ReviewCollectionViewCells.identifier)
        
        return cv
    }()
    

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setTransparentNavbar()
        headerView.configureComponents(merchant: merchant!)
        configReviewCV()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configUI()
        UIView.animate(withDuration: 0.35) {
            self.headerView.frame.origin.y = 0
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = navigationController?.viewControllers.first as? MainViewController else {return}
        vc.hideNavbar()
        self.navigationController?.navigationBar.tintColor = .black
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
            self.menuView.addSubview(self.menu1){
                self.menu1.setAnchor(top: self.menuView.topAnchor, left: self.menuView.leftAnchor, paddingTop: 8, paddingLeft: 8)
            }
            self.menuView.addSubview(self.harga1){
                self.harga1.setAnchor(top: self.menuView.topAnchor, right: self.menuView.rightAnchor, paddingTop: 8, paddingRight: 8)
            }

            self.menuView.addSubview(self.menu2){
                    self.menu2.setAnchor(top: self.menu1.topAnchor, left: self.menuView.leftAnchor, paddingTop: 24, paddingLeft: 8)
                }
            self.menuView.addSubview(self.harga2){
                self.harga2.setAnchor(top: self.menu1.topAnchor, right: self.menuView.rightAnchor, paddingTop: 24, paddingRight: 8)
            }

            self.menuView.addSubview(self.menu3){
                   self.menu3.setAnchor(top: self.menu2.topAnchor, left: self.menuView.leftAnchor, paddingTop: 24, paddingLeft: 8)
               }
           self.menuView.addSubview(self.harga3){
               self.harga3.setAnchor(top: self.menu2.topAnchor, right: self.menuView.rightAnchor, paddingTop: 24, paddingRight: 8)
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
        
        self.scrollView.addSubview(collectionViewReview){
            self.collectionViewReview.setAnchor(top: self.reviewLabel.bottomAnchor ,right: self.view.rightAnchor, bottom: self.scrollView.bottomAnchor,left: self.view.leftAnchor)
            self.collectionViewReview.setSize( height: 1005)
        }
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func configReviewCV(){
        configDatasource()
        configSnapshott()
    }

    private func configDatasource(){
        checkDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionViewReview) { (collectionV, indexPath, review) -> UICollectionViewCell? in
            guard let cell = collectionV.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCells.identifier, for: indexPath) as? ReviewCollectionViewCells else {return UICollectionViewCell()}
            cell.details = review
            cell.configureCells()
            return cell
        }
    }
    
    private func configSnapshott(){
        checkSnapshot = CollectionSnapshot()
        checkSnapshot!.appendSections([.main])
        checkSnapshot!.appendItems(Review.reviewDetails, toSection: .main)
        checkDataSource?.apply(checkSnapshot!, animatingDifferences: true, completion: nil)
    }


}

extension MerchantViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let merchantReview = checkDataSource?.itemIdentifier(for: indexPath)
        print("DEBUGS Merchant Review : \(merchantReview!.userName)")
    }
}

//MARK: - Main Header View Delegate
extension MerchantViewController: MerchantHeaderViewDelegate {
    func backButtView() {

    }

    func favDidTapped() {
        print("DEBUGS: Fav is Tapped!")
    }
}

extension MerchantViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == badgeCollectionView{
                    return Badges.dataBagde.count
        }
        return Badges.dataBagde.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BadgeCollectionViewCell
        cell.backgroundColor = .white

        if collectionView == badgeCollectionView{
            cell.configBadgeCV()
            cell.badgeData = Badges.dataBagde[indexPath.row]
            return cell
        }
        cell.configPhotoCV()
        cell.photoData = Badges.dataBagde[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == badgeCollectionView{
            return CGSize(width: 84 , height: 106)
        }
        return CGSize(width: 135, height: 135)
    }
    
}
