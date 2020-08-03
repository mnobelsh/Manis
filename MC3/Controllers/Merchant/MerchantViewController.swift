//
//  MerchantViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

enum Sectiono: Int{
    case main = 0
}

typealias CollectionVDataSource = UICollectionViewDiffableDataSource<Sectiono,Review>
typealias CollectionVSnapshot = NSDiffableDataSourceSnapshot<Sectiono,Review>

class MerchantViewController: UIViewController {
    
    var merchant: Merchant? {
        didSet{
            
        }
    }
    
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
        scrollV.contentSize = CGSize(width: self.view.frame.width, height: 1150)
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
    
    private lazy var badgeView2: UIView = {
        let view = UIView()
        view.configureBadge(badge: #imageLiteral(resourceName: "bigBadge2"), title: "Great Taste", total: "45")
        
        return view
    }()
    
    private lazy var badgeView3: UIView = {
        let view = UIView()
        view.configureBadge(badge: #imageLiteral(resourceName: "bigBadge3"), title: "Clean Tools", total: "20")
        
        return view
    }()
    
    private lazy var badgeView1: UIView = {
        let view = UIView()
        view.configureBadge(badge: #imageLiteral(resourceName: "bigBadge1"), title: "Clean Ice", total: "30")
        
        return view
    }()
    
    private lazy var stackBadge: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [badgeView2,badgeView3,badgeView1])
        stack.spacing = 4
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        return stack
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
    
    private lazy var photos: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "es cendol logo")
        img.setSize(width: 150, height: 150)
        return img
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Reviews", fontSize: 20, textColor: .black)
        return label
    }()
    
    //MARK: - CollectionView Review
    private var DataSource: CollectionVDataSource?
    private var SnapShott:CollectionVSnapshot?
    
    private var collectionViews: UICollectionView!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTransparentNavbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.35) {
            self.headerView.frame.origin.y = 0
        }
        self.view.addSubview(self.headerView)
        configUI()
        headerView.configureComponents(merchant: merchant!)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = navigationController?.viewControllers.first as? MainViewController else {return}
        vc.hideNavbar()
    }
    
    func configUI(){
        configureAllCV()
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
            self.badgeLabel.setAnchor(top: self.priceRange.bottomAnchor, left: self.view.leftAnchor, paddingTop: 12, paddingRight: 8, paddingBottom: 8, paddingLeft: 16)
        }

        self.scrollView.addSubview(stackBadge){
           self.stackBadge.setAnchor(top: self.badgeLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: 4, paddingRight: 8, paddingBottom: 8, paddingLeft: 16)
        }

        self.scrollView.addSubview(menuLabel){
            self.menuLabel.setAnchor(top: self.badgeView2.bottomAnchor, left: self.view.leftAnchor, paddingTop: 12, paddingRight: 8, paddingBottom: 8, paddingLeft: 16)
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

        self.scrollView.addSubview(photos){
            self.photos.setAnchor(top: self.photoLabel.bottomAnchor, left: self.view.leftAnchor, paddingTop: 8, paddingLeft: 16)
        }
        
        self.scrollView.addSubview(reviewLabel){
            self.reviewLabel.setAnchor(top: self.photos.bottomAnchor, left: self.view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        }
        
        self.scrollView.addSubview(collectionViews){
            self.collectionViews.setAnchor(top: self.reviewLabel.bottomAnchor, right: self.view.rightAnchor, left: self.view.leftAnchor, paddingTop: 8,paddingRight: 8,paddingLeft: 8)
        }
        
    }
    
    func configureAllCV(){
        print("DEBUGS before layout")
//        let collectionViewsLayout = UICollectionViewCompositionalLayout { (sections, envs) -> NSCollectionLayoutSection? in
//            var item: NSCollectionLayoutItem!
//            var group: NSCollectionLayoutGroup!
//
//            print("DEBUGS While set up Layput")
//
//            if sections == Sectiono.main.rawValue {
//                //ITEM
//                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//
//                //GROUP
//                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330)), subitems: [item])
//                print("DEBUGS: LAYOUT MASUKS")
//            } else {
//                print("DEBUGS: Layout ga masuk!")
//            }
//
//            //SECTION
//            let sections = NSCollectionLayoutSection(group: group)
//            sections.contentInsets.top = 8
//            return sections
//        }
        
        let CVLayout = UICollectionViewCompositionalLayout { (sect, envs)-> NSCollectionLayoutSection? in
            var items: NSCollectionLayoutItem!
            var groups: NSCollectionLayoutGroup!
            
            print("DEBUGS : While Set up Layout")
            
            if sect == Sectiono.main.rawValue{
                //ITEM
                items = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                items.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                //GROUP
                groups = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330)), subitems: [items])
                print("DEBUGS : ITEM GROUP MASUK")
            } else {
                print("DEBUGS : Layout ga masuk!")
            }
            
            //SECTION
            let sect = NSCollectionLayoutSection(group: groups)
            sect.contentInsets.top = 8
            return sect
        }
        
        print("DEBUGS After Layput")
        
        //SET LAYOUUT
        collectionViews = UICollectionView(frame: .zero, collectionViewLayout: CVLayout)
        collectionViews.backgroundColor = .clear
        collectionViews.delegate = self
        collectionViews.register(ReviewCollectionViewCells.self, forCellWithReuseIdentifier: ReviewCollectionViewCells.identifier)
        
        //DATA SOURCE
        DataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionViews) { (collectionViews, indexPath, review) -> UICollectionViewCell? in
        
        guard let cell = collectionViews.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCells.identifier, for: indexPath) as? ReviewCollectionViewCells else {return UICollectionViewCell()}
        cell.details = review
        
        cell.configureCells()
        
        return cell
        }
        
        configureCVSnapshot()
    }
    
    private func configureCVSnapshot(){
        SnapShott = CollectionVSnapshot()
        SnapShott!.appendSections([.main])
        SnapShott?.appendItems(Review.reviewDetails, toSection: .main)
        DataSource?.apply(SnapShott!,animatingDifferences: true, completion: nil)
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

extension MerchantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = DataSource?.itemIdentifier(for: indexPath)
        print("SELECTED Merchant : \(review!.userName)")
    }
}
