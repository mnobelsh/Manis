////
////  MerchantVC.swift
////  MC3
////
////  Created by Muhammad Thirafi on 03/08/20.
////  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
////
//
//import UIKit
//
//typealias MerchantCollectionDataSource = UICollectionViewDiffableDataSource<MerchantCVSection,Merchant>
//typealias MerchantCollectionSnapshot = NSDiffableDataSourceSnapshot<MerchantCVSection,Merchant>
//
//class MerchantVC: UIViewController {
//
//    var detail: Merchant? {
//        didSet{
//
//        }
//    }
//
//    private var Datasource: MerchantCollectionDataSource?
//    private var snapShot: MerchantCollectionSnapshot?
//
//    private lazy var headerView: MerchantHeaderView = {
//        let header = MerchantHeaderView(frame: .init(x: 0, y: -MerchantHeaderView.height, width: self.view.frame.width, height: MerchantHeaderView.height))
//        header.delegate = self
//        return header
//    }()
//
//    private lazy var scrollView: UIScrollView = {
//       let scrollV = UIScrollView()
//        scrollV.frame = self.view.bounds
//        scrollV.contentInset = .zero
//        scrollV.automaticallyAdjustsScrollIndicatorInsets = false
//        scrollV.contentSize = CGSize(width: self.view.frame.width, height: 1150)
//        scrollV.showsHorizontalScrollIndicator = false
//        scrollV.contentInsetAdjustmentBehavior = .never
//        scrollV.alwaysBounceVertical = false
//
//        return scrollV
//    }()
//
//    //COLLECTION VIEW
//    private lazy var collectionViews: UICollectionView = {
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: configMerchantCVLayout())
//        cv.backgroundColor = .systemBackground
//        cv.delegate = self
//        cv.isScrollEnabled = false
//
//        cv.register(DetailMerchantCollectionViewCell.self, forCellWithReuseIdentifier: DetailMerchantCollectionViewCell.identifier)
//        cv.register(SectTitleView.self,forSupplementaryViewOfKind: SectTitleView.kind , withReuseIdentifier: SectTitleView.identifier)
//
//        return cv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setTransparentNavbar()
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 0.35) {
//            self.headerView.frame.origin.y = 0
//        }
//        self.view.addSubview(self.headerView)
//        confDiffableDataSource()
//        configUI()
//
//        headerView.configureComponents(merchant: detail!)
//
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.tintColor = .white
//    }
//
////    func configBadgeVC(){
////        Datasource = UICollectionViewDiffableDataSource(collectionView: self.badgeCV { (badgeView, indexPath, badge) -> UICollectionViewCell? in
////
////            guard let cell
////        })
////
////        }
////    }
//
//    func configUI(){
//        view.backgroundColor = .systemBackground
//        self.view.addSubview(scrollView)
//
//        self.scrollView.addSubview(self.headerView)
//        self.scrollView.addSubview(collectionViews){
//            self.collectionViews.setAnchor(top: self.headerView.bottomAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor, paddingTop: 20)
//        }
//    }
//
//    private func confDiffableDataSource(){
//        configureDataSource()
//        configureSectionTitleView()
//        configureSnapshot()
//    }
//
//    private func configureSectionTitleView() {
//        Datasource?.supplementaryViewProvider = .some({(collectionViews,kind,indexPath) -> UICollectionReusableView? in
//            guard let titleView = collectionViews.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectTitleView.identifier, for: indexPath) as? SectTitleView else {return UICollectionReusableView()}
//
//            switch indexPath.section{
//            case MerchantCVSection.priceRanges.rawValue:
//                titleView.titles = "Price Range"
//                titleView.linkTypes = .empty
//            case MerchantCVSection.badges.rawValue:
//                titleView.titles = "Badge"
//                titleView.linkTypes = .empty
//            case MerchantCVSection.menus.rawValue:
//                titleView.titles = "Menu"
//                titleView.linkTypes = .seeAll
//            case MerchantCVSection.photos.rawValue:
//                titleView.titles = "Photo"
//                titleView.linkTypes = .empty
//            case MerchantCVSection.reviews.rawValue:
//                titleView.titles = "Reviews"
//                titleView.linkTypes = .seeAll
//            default:
//                titleView.titles = "Details"
//        }
//            return titleView
//        })
//    }
//
//    private func configureDataSource(){
//        Datasource = UICollectionViewDiffableDataSource(collectionView: self.collectionViews) { (collectionview, indexPath, details) -> UICollectionViewCell? in
//            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: DetailMerchantCollectionViewCell.identifier, for: indexPath) as? DetailMerchantCollectionViewCell else {return UICollectionViewCell()}
//            cell.detail = details
//
//            if indexPath.section == MerchantCVSection.priceRanges.rawValue{
//                cell.configurePriceRangeCell()
//            } else if indexPath.section == MerchantCVSection.badges.rawValue{
//                cell.configureBadgeCell()
//            } else if indexPath.section == MerchantCVSection.menus.rawValue{
//                cell.configureMenuCell()
//            } else if indexPath.section == MerchantCVSection.photos.rawValue{
//                cell.configurePhotoCell()
//            } else {
//                cell.configureReviewCell()
//            }
//            print("DEBUGS : data source")
//            return cell
//
//        }
//    }
//
//    private func configureSnapshot(){
//        snapShot = MerchantCollectionSnapshot()
//        snapShot!.appendSections([.priceRanges,.badges,.menus,.photos,.reviews])
////        snapShot!.appendItems([detail?.priceRange], toSection: .priceRanges)
//        snapShot!.appendItems(Merchant.nearbyMerchants)
//        snapShot!.appendItems(Merchant.highestRatingMerchants)
//        Datasource?.apply(snapShot!, animatingDifferences: true, completion: nil)
//    }
//
//}
//
//extension MerchantVC: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let merchant = Datasource?.itemIdentifier(for: indexPath)
//        print("SELECTED Merchant: \(merchant!.name)")
//    }
//}
//
//extension MerchantVC: MerchantHeaderViewDelegate{
//
//    func favDidTapped(){
//        print("DEBUGS : Fav is tapped")
//    }
//}
