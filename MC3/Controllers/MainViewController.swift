//
//  HomeViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

typealias MainCollectionDataSource = UICollectionViewDiffableDataSource<MainCollectionViewSection,Merchant>
typealias MainCollectionSnapshot = NSDiffableDataSourceSnapshot<MainCollectionViewSection,Merchant>
typealias SearchResultTableViewDataSource = UITableViewDiffableDataSource<MerchantTableViewSection, Merchant>
typealias SearchResultSnapshot = NSDiffableDataSourceSnapshot<MerchantTableViewSection, Merchant>

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var locationHandler = LocationHandler.shared
    private var collectionViewDataSource: MainCollectionDataSource?
    private var collectionViewSnapshot: MainCollectionSnapshot?
    private var tableViewDataSource: SearchResultTableViewDataSource?
    private var tableViewSnapShot: SearchResultSnapshot?
    
    private var nearbyMerchants: [Merchant] = [Merchant]()  {
        didSet {
            let userLocation = locationHandler.manager.location!
            self.nearbyMerchants = self.nearbyMerchants.sorted{  (merchant1, merchant2) -> Bool in
                merchant1.location.distance(from: userLocation) < merchant2.location.distance(from: userLocation)
            }
            updateCollectionViewSnapshot(merchantData: self.nearbyMerchants, forSection: .nearby)
        }
    }
    private var highRatingMerchants: [Merchant] = [Merchant]() {
        didSet {
            updateCollectionViewSnapshot(merchantData: self.highRatingMerchants, forSection: .rating)
        }
    }
    private var trendingMerchants: [Merchant] = [Merchant]() {
        didSet{
            self.trendingMerchants = self.trendingMerchants.sorted { (merchant1, merchant2) -> Bool in
                merchant1.lovedBy > merchant2.lovedBy
            }
            updateCollectionViewSnapshot(merchantData: self.trendingMerchants, forSection: .trendings)
        }
    }
    private var searchResultMerchants: [Merchant] = [Merchant]() {
        didSet {
            print(self.searchResultMerchants)
            self.configureTableViewSnapshot()
        }
    }
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = self.view.bounds
        scrollV.contentInset = .zero
        scrollV.automaticallyAdjustsScrollIndicatorInsets = false
        scrollV.contentSize = CGSize(width: self.view.frame.width, height: 1150)
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.alwaysBounceVertical = false
        scrollV.delegate = self
        
        return scrollV
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configureMainCollectionViewLayout())
        
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.isScrollEnabled = false
        
        cv.register(MerchantCollectionCell.self, forCellWithReuseIdentifier: MerchantCollectionCell.identifier)
        cv.register(SectionTitleView.self, forSupplementaryViewOfKind: SectionTitleView.kind, withReuseIdentifier: SectionTitleView.identifier)
        
        return cv
    }()
    private lazy var headerContainerView: MainHeaderView = {
        let headerView = MainHeaderView(frame: .init(x: 0, y: -MainHeaderView.height, width: self.view.frame.width, height: MainHeaderView.height))
        headerView.delegate = self
        headerView.configureSearchBar(delegate: self)
        headerView.configureCollectionView(delegate: self, dataSource: self)
        return headerView
    }()
    private lazy var searchResultView: SearchResultView = {
        let searchView = SearchResultView(frame: .init(x: 0, y: self.scrollView.frame.height + ( self.scrollView.frame.height - MainHeaderView.height), width: self.view.frame.width, height: SearchResultView.height))
        searchView.configureTableView(delegate: self)
        return searchView
    }()
    private var userPlacemark: CLPlacemark? {
        didSet {
            self.headerContainerView.placeMark = userPlacemark
        }
    }
    var currentUser: User? {
        didSet {
            print("CURRENT USER : \(currentUser)")
        }
    }
    private let service = FirebaseService.shared
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        locationHandler.delegate = self
        locationHandler.requestLocation()
        configureComponents()
        authorizeUserLocationAndFetch()
        fetchUser()
        print("DEBUGS : DID LOAD")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.35) {
            self.headerContainerView.frame.origin.y = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavbar()
    }
    
    
    // MARK: - Helpers
    
    private func configureComponents() {        
        configureDiffableDataSource()
        
        let hideKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSearchBarKeyboard))
        hideKeyboardTapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(hideKeyboardTapGesture)
    }
    
    func configureUI() {
        title = "Home"
        view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        self.searchResultView.isHidden = true
        
        self.scrollView.addSubview(self.headerContainerView)
        
        self.scrollView.addSubview(collectionView) {
            self.collectionView.setAnchor(top: self.headerContainerView.bottomAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor, paddingTop: 20)
        }
        
        self.scrollView.addSubview(searchResultView)
        hideNavbar()
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func authorizeUserLocationAndFetch() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,.authorizedWhenInUse:
            self.fetchMerchantsData()
            self.setPlacemark(withLocation: self.locationHandler.manager.location!) { (placeMark) in
                self.userPlacemark = placeMark
            }
            configureUI()
        case .denied :
            showSetting()
        default:
            locationHandler.requestLocation()
        }
    }
    
    private func showSetting() {
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url)
    }
    
    func fetchUser() {
        if let user = Auth.auth().currentUser {
            service.fetchUser(userID: user.uid) { (user) in
                DispatchQueue.main.async {
                    self.currentUser = user
                }
            }
        }
    }
    
    // MARK: - Collection View Configuration
    private func configureDiffableDataSource() {
        configureCollectionViewDataSource()
        configureCollectionViewSectionTitleView()
        configureCollectionViewSnapshot()
        
        configureTableViewDataSource()
        configureTableViewSnapshot()
    }
    
    private func configureCollectionViewSectionTitleView() {
        collectionViewDataSource?.supplementaryViewProvider = .some({ (collectionview, kind, indexPath) -> UICollectionReusableView? in
            guard let titleView = collectionview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleView.identifier, for: indexPath) as? SectionTitleView else {return UICollectionReusableView()}
            titleView.delegate = self
            switch indexPath.section {
                case MainCollectionViewSection.trendings.rawValue:
                    titleView.title = "Trendings"
                    titleView.linkType = .empty
                case MainCollectionViewSection.nearby.rawValue:
                    titleView.title = "Nearby"
                    titleView.linkType = .seeOnMap
                case MainCollectionViewSection.rating.rawValue:
                    titleView.title = "High Rating"
                    titleView.linkType = .seeAll
                default:
                    titleView.title = "Merchants"
            }
            
            return titleView
        })
    }
    
    private func configureCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionview, indexPath, merchant) -> UICollectionViewCell? in

            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MerchantCollectionCell.identifier, for: indexPath) as? MerchantCollectionCell else {return UICollectionViewCell()}
            
            cell.data = merchant

            if indexPath.section == MainCollectionViewSection.trendings.rawValue {
                cell.rank = indexPath.row+1
                cell.configureTrendingCell()
            } else {
                cell.configureMerchantCell()
            }
            
            return cell
        }
    }
    
    private func configureCollectionViewSnapshot() {
        self.collectionViewSnapshot = MainCollectionSnapshot()
        collectionViewSnapshot!.appendSections([.nearby,.rating,.trendings])
        collectionViewDataSource!.apply(collectionViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func updateCollectionViewSnapshot(merchantData merchants: [Merchant], forSection section: MainCollectionViewSection) {
        self.collectionViewSnapshot!.appendItems(merchants, toSection: section)
        collectionViewDataSource!.apply(collectionViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    

    // MARK: - Table View Configuration
    private func configureTableViewDataSource() {
        tableViewDataSource = UITableViewDiffableDataSource(tableView: searchResultView.resultTableView, cellProvider: { (tableview, indexPath, merchant) -> UITableViewCell? in
            
            guard let cell = tableview.dequeueReusableCell(withIdentifier: MerchantTableCell.identifier, for: indexPath) as? MerchantTableCell else {return UITableViewCell()}
            cell.merchant = merchant
            cell.configureComponents()
            return cell
        })
    }
    
    private func configureTableViewSnapshot() {
        self.tableViewSnapShot = SearchResultSnapshot()
        tableViewSnapShot!.appendSections([.main])
        self.tableViewSnapShot!.appendItems(self.searchResultMerchants, toSection: .main)
        tableViewDataSource!.apply(tableViewSnapShot!, animatingDifferences: true, completion: nil)
    }

    
    // MARK: - Fetch Data
    private func fetchNearbyMerchants() {
        service.fetchNearbyMerchants(location: locationHandler.manager.location!, withRadius: 0.2) { (merchant, merchantLocation) in
            DispatchQueue.main.async {
                self.nearbyMerchants.append(merchant)
            }
        }
    }
    
    private func fetchHighRatingMerchants(limitMerchants limit: Int? = nil) {
        service.fetchHighRatingMerchants(limitMerchants: limit) { (merchant) in
            DispatchQueue.main.async {
                self.highRatingMerchants.append(merchant)
            }
        }
    }
    
    private func fetchTrendingMerchants(limitMerchants limit: Int? = nil) {
        service.fetchTrendingMerchants(limitMerchants: limit) { (merchant) in
            DispatchQueue.main.async {
                self.trendingMerchants.append(merchant)
            }
        }
    }
    
    private func fetchMerchantsData() {
        fetchNearbyMerchants()
        fetchHighRatingMerchants(limitMerchants: 5)
        fetchTrendingMerchants(limitMerchants: 3)
    }
    
    private func searchMerchantsByName(merchantName: String) {
        var merchants = [Merchant]()
        service.fetchMerchants { (merchant) in
            DispatchQueue.main.async {
                    if merchant.name.lowercased().contains(merchantName) {
                    merchants.append(merchant)
                    self.searchResultMerchants = merchants
                }
            }
        }
    }
    

    
    // MARK: - Targets
    @objc private func hideSearchBarKeyboard() {
        self.headerContainerView.searchBar.resignFirstResponder()
    }

}

// MARK: - Main Header View Delegate
extension MainViewController: MainHeaderViewDelegate {

    func hideSearchHeaderView() {
        self.scrollView.isScrollEnabled = true
        self.headerContainerView.isSearchViewHidden = true
        self.searchResultView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
            self.searchResultView.frame.origin.y = self.scrollView.frame.height + ( self.scrollView.frame.height - MainHeaderView.height)
        }
        
    }
    
    func avatarDidTap() {
        if let _ = Auth.auth().currentUser {
             self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        } else {
            let signinVC = UINavigationController(rootViewController: SignInViewController())
            signinVC.modalPresentationStyle = .fullScreen
            self.present(signinVC, animated: true, completion: nil)
        }
    }
    
    func locationDidChanged(locationLabel: UILabel) {

    }
    
}

// MARK: - Collection View Delegate & DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sorting.types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortingCollectionViewCell.identifier, for: indexPath) as? SortingCollectionViewCell else {return UICollectionViewCell()}
        cell.cellData = Sorting.types[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            
            let merchantVC = MerchantViewController()
            merchantVC.merchant = collectionViewDataSource?.itemIdentifier(for: indexPath)
            self.navigationController?.pushViewController(merchantVC, animated: true)
            
        } else if collectionView == self.headerContainerView.sortingCollectionView {
            
            collectionView.subviews.forEach { (view) in
                guard let cell = view as? SortingCollectionViewCell else {return}
                cell.backgroundColor = cell.isSelected ?  .darkGray : .systemBackground
                cell.setLabelColorContrastToBackground()
            }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: collectionView.frame.height - 10)
    }
    
}

// MARK: - Table View Delegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let merchantVC = MerchantViewController()
        merchantVC.merchant = tableViewDataSource?.itemIdentifier(for: indexPath)
        self.navigationController?.pushViewController(merchantVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
}

// MARK: - Search Bar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let titleSearched = searchBar.text else {return}
        self.searchMerchantsByName(merchantName: titleSearched)
        searchBar.resignFirstResponder()
        self.headerContainerView.resetSortingCellAppereance()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.scrollView.isScrollEnabled = false
        self.headerContainerView.isSearchViewHidden = false
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 0
            self.searchResultView.frame.origin.y = MainHeaderView.height - 10
            self.searchResultView.isHidden = false
        }
        self.scrollView.bringSubviewToFront(self.headerContainerView)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("CANCEL")
    }
    
}

// MARK: - Scroll View Delegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

// MARK: - Section Title Delegate
extension MainViewController: SectionTitleViewDelegate {
    func seeOnMapButtonDidTap() {
        let mapViewVC = MapViewController()
        self.navigationController?.pushViewController(mapViewVC, animated: true)
    }
    
    func seeAllButtonDidTap() {
        let merchantListVC = MerchantListViewController()
        merchantListVC.merchantListType = .highRating
        self.navigationController?.pushViewController(merchantListVC, animated: true)
    }
}

// MARK: - Location Handler Delegate
extension MainViewController: LocationHandlerDelegate {
    func locationUnauthorized() {
        showSetting()
    }
}


