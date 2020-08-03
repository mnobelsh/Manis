//
//  HomeViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

typealias MainCollectionDataSource = UICollectionViewDiffableDataSource<MainCollectionViewSection,Merchant>
typealias MainCollectionSnapshot = NSDiffableDataSourceSnapshot<MainCollectionViewSection,Merchant>
typealias SearchResultTableViewDataSource = UITableViewDiffableDataSource<SearchResultTableViewSection, Merchant>
typealias SearchResultSnapshot = NSDiffableDataSourceSnapshot<SearchResultTableViewSection, Merchant>


class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var collectionViewDataSource: MainCollectionDataSource?
    private var collectionViewSnapshot: MainCollectionSnapshot?
    private var tableViewDataSource: SearchResultTableViewDataSource?
    private var tableViewSnapShot: SearchResultSnapshot?
    
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
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureComponents()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.35) {
            self.headerContainerView.frame.origin.y = 0
        }
    }
    
    // MARK: - Helpers
    private func configureComponents() {
        configureDiffableDataSource()
        
        let hideKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSearchBarKeyboard))
        hideKeyboardTapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(hideKeyboardTapGesture)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(self.headerContainerView)
        
        self.scrollView.addSubview(collectionView) {
            self.collectionView.setAnchor(top: self.headerContainerView.bottomAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor, paddingTop: 20)
        }
        
        self.scrollView.addSubview(searchResultView)
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
            
            switch indexPath.section {
                case MainCollectionViewSection.trendings.rawValue:
                    titleView.title = "Trendings"
                    titleView.linkType = .empty
                case MainCollectionViewSection.nearby.rawValue:
                    titleView.title = "Nearby"
                    titleView.linkType = .seeOnMap
                case MainCollectionViewSection.rating.rawValue:
                    titleView.title = "Highest Rating"
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
        collectionViewSnapshot = MainCollectionSnapshot()
        collectionViewSnapshot!.appendSections([.nearby,.rating,.trendings])
        collectionViewSnapshot!.appendItems(Merchant.trendingsDessert, toSection: .trendings)
        collectionViewSnapshot!.appendItems(Merchant.nearbyMerchants, toSection: .nearby)
        collectionViewSnapshot!.appendItems(Merchant.highestRatingMerchants, toSection: .rating)
        collectionViewDataSource?.apply(collectionViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func configureTableViewDataSource() {
        tableViewDataSource = UITableViewDiffableDataSource(tableView: searchResultView.resultTableView, cellProvider: { (tableview, indexPath, merchant) -> UITableViewCell? in
            
            guard let cell = tableview.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else {return UITableViewCell()}
            cell.merchant = merchant
            return cell
        })
    }
    
    private func configureTableViewSnapshot() {
        tableViewSnapShot = SearchResultSnapshot()
        tableViewSnapShot?.appendSections([.result])
        tableViewSnapShot?.appendItems(Merchant.searchResult, toSection: .result)
        tableViewDataSource?.apply(tableViewSnapShot!, animatingDifferences: true, completion: nil)
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
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
            self.searchResultView.frame.origin.y = self.scrollView.frame.height + ( self.scrollView.frame.height - MainHeaderView.height)
        }
        
    }
    
    func avatarDidTapped() {
        print("DEBUGS : AVATAR TAPPED")
    }
    
    func locationDidChanged(locationLabel: UILabel) {
        print("DEBUGS : LOCATION LABEL TAPPED \(locationLabel.text!)")
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
            
            let merchant = collectionViewDataSource?.itemIdentifier(for: indexPath)
            print("SELECTED MERCHANT : \(merchant!.name)")
            
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = (self.view.frame.height - MainHeaderView.height) / 5
        height = height < 130 ? 130 : height
        return height
    }
}

// MARK: - Search Bar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.headerContainerView.resetSortingCellAppereance()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.scrollView.isScrollEnabled = false
        self.headerContainerView.isSearchViewHidden = false
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 0
            self.searchResultView.frame.origin.y = MainHeaderView.height - 10
        }
        self.scrollView.bringSubviewToFront(self.headerContainerView)
    }
    
}


