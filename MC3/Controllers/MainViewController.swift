//
//  HomeViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

enum MainCollectionViewSection: Int {
    case trendings = 2, nearby = 0, rating = 1
}
typealias MainCollectionDataSource = UICollectionViewDiffableDataSource<MainCollectionViewSection,Merchant>
typealias MainCollectionSnapshot = NSDiffableDataSourceSnapshot<MainCollectionViewSection,Merchant>

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var exploreDessert: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Doger", address: "Jl. Serpong Raya 1", lovedCount: 120),
                                              Merchant(id: UUID().uuidString, name: "Es Campur", address: "Jl. Serpong Raya 12", lovedCount: 75),
                                              Merchant(id: UUID().uuidString, name: "Es Goyobod", address: "Jl. Serpong Raya 3", lovedCount: 90),
                                              Merchant(id: UUID().uuidString, name: "Es Campur", address: "Jl. Serpong Raya 5", lovedCount: 50),
                                              Merchant(id: UUID().uuidString, name: "Es Doger", address: "Jl. Serpong Raya 6", lovedCount: 100)]
    private var nearbyMerchants: [Merchant] =  [Merchant(id: UUID().uuidString, name: "Es Cincau Mang Ucup", address: "Jl. Serpong Raya 10", lovedCount: 111),
                                                Merchant(id: UUID().uuidString, name: "Es Teler Uhuy", address: "Jl. Serpong Raya 13", lovedCount: 111),
                                                Merchant(id: UUID().uuidString, name: "Es Pisang Ijo Prikitiew", address: "Jl. Serpong Raya 56", lovedCount: 111),]
    private var highestRatingMerchants: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Puter Linlin", address: "Jl. Serpong Raya 99", lovedCount: 111),
                                                      Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari", address: "Jl. Serpong Raya 11", lovedCount: 111),
                                                      Merchant(id: UUID().uuidString, name: "Es Bahenol", address: "Jl. Serpong Raya 17", lovedCount: 111),]
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: MainCollectionDataSource?
    private var collectionViewSnapshot: MainCollectionSnapshot?
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = self.view.bounds
        scrollV.contentInset = .zero
        scrollV.automaticallyAdjustsScrollIndicatorInsets = false
        scrollV.contentSize = CGSize(width: self.view.frame.width, height: 1350)
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.alwaysBounceVertical = false

        return scrollV
    }()
    private var headerContainerView: MainHeaderView!
    private var searchResultView: SearchResultView!
    
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
        configureCollectionView()

        let hideKeyboardTapGesture = UITapGestureRecognizer(target: self, action: #selector(hideSearchBarKeyboard))
        hideKeyboardTapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(hideKeyboardTapGesture)
        
        self.headerContainerView = MainHeaderView(frame: .init(x: 0, y: -MainHeaderView.height, width: self.view.frame.width, height: MainHeaderView.height))
        self.headerContainerView.delegate = self
        self.headerContainerView.configureSearchBarDelegate(delegate: self)
        self.headerContainerView.configureCollectionViewDelegateAndDataSource(delegate: self, dataSource: self)
        
        self.searchResultView = SearchResultView(frame: .init(x: 0, y: self.scrollView.frame.height + ( self.scrollView.frame.height - MainHeaderView.height), width: self.view.frame.width, height: SearchResultView.height))

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
    private func configureCollectionView() {
        
        let collectionViewLayout = UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in
            var item: NSCollectionLayoutItem!
            var group: NSCollectionLayoutGroup!
            var section: NSCollectionLayoutSection!
            let sectionTitleSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: SectionTitleView.kind, alignment: .topLeading)
            
            if sectionIndex == MainCollectionViewSection.trendings.rawValue {
                
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(110)), subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets.trailing = 8
            } else {
                
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(165), heightDimension: .absolute(200)), subitems: [item])
                
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            }

            section.contentInsets.leading = 8
            section.contentInsets.bottom = 15
            section.boundarySupplementaryItems = [sectionTitleSupplementaryItem]
            
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        self.collectionView.register(MerchantCollectionCell.self, forCellWithReuseIdentifier: MerchantCollectionCell.identifier)
        self.collectionView.register(SectionTitleView.self, forSupplementaryViewOfKind: SectionTitleView.kind, withReuseIdentifier: SectionTitleView.identifier)
        
        configureCollectionViewDataSource()
        configureCollectionViewSectionTitleView()
        configureCollectionViewSnapshot()
        
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
                cell.rankLabel.text = "\(indexPath.row+1)"
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
        collectionViewSnapshot!.appendItems(exploreDessert, toSection: .trendings)
        collectionViewSnapshot!.appendItems(nearbyMerchants, toSection: .nearby)
        collectionViewSnapshot!.appendItems(highestRatingMerchants, toSection: .rating)
        collectionViewDataSource?.apply(collectionViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    // MARK: - Targets
    @objc private func hideSearchBarKeyboard() {
        self.headerContainerView.searchBar.resignFirstResponder()
    }

}

// MARK: - Main Header View Delegate
extension MainViewController: MainHeaderViewDelegate {
    func showSearchHeaderView() {

    }
    
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
        print("DEBUGS : LOCATION LABEL TAPPED \(locationLabel.text)")
    }
    
}

// MARK: - Collection View Delegate & DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let merchant = collectionViewDataSource?.itemIdentifier(for: indexPath)
            print("SELECTED MERCHANT : \(merchant!.name)")
        } else if collectionView == self.headerContainerView.sortingCollectionView {
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height - 10)
    }
    
    
}

// MARK: - Search Bar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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

