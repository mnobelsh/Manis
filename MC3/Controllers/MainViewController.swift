//
//  HomeViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import ChameleonFramework

enum CollectionViewSection: Int {
    case trendings = 2, nearby = 0, rating = 1
}
typealias MainCollectionDataSource = UICollectionViewDiffableDataSource<CollectionViewSection,Merchant>
typealias MainCollectionSnapshot = NSDiffableDataSourceSnapshot<CollectionViewSection,Merchant>

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var exploreDessert: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Doger"),
                                              Merchant(id: UUID().uuidString, name: "Es Campur"),
                                              Merchant(id: UUID().uuidString, name: "Es Goyobod"),
                                              Merchant(id: UUID().uuidString, name: "Es Campur"),
                                              Merchant(id: UUID().uuidString, name: "Es Doger")]
    private var nearbyMerchants: [Merchant] =  [Merchant(id: UUID().uuidString, name: "Es Cincau Mang Ucup"),
                                                Merchant(id: UUID().uuidString, name: "Es Teler Uhuy"),
                                                Merchant(id: UUID().uuidString, name: "Es Pisang Ijo Prikitiew"),]
    private var highestRatingMerchants: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Puter Linlin"),
                                                      Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari"),
                                                      Merchant(id: UUID().uuidString, name: "Es Bahenol"),]
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

        return scrollV
    }()
    private var headerContainerView: UIView = {
        let view = UIView()
        view.setSize(height: 200)
        view.backgroundColor = #colorLiteral(red: 0.9706575274, green: 0.9708197713, blue: 0.9706360698, alpha: 1)
        view.configureShadow(shadowColor: .lightGray, radius: 2)
        view.configureRoundedCorners(corners: [.bottomLeft,.bottomRight], radius: 12)
        return view
    }()
    private var avatarImageView: AvatarImageView = {
        let avatarImage = AvatarImageView(frame: .zero)
        avatarImage.configureAvatarView(avatarImage: #imageLiteral(resourceName: "avatar"), withDimension: 65)
        return avatarImage
    }()
    private var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.autocapitalizationType = .none
        searchbar.autocorrectionType = .no
        searchbar.backgroundColor = .clear
        searchbar.searchBarStyle = .minimal
        searchbar.placeholder = "Search"
        searchbar.setSize(height: 40)
        return searchbar
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(headerContainerView) {
            self.headerContainerView.setAnchor(top: self.scrollView.topAnchor, right: self.view.rightAnchor, left: self.view.leftAnchor)
        }

        self.headerContainerView.addSubview(searchBar) {
            self.searchBar.setAnchor(right: self.headerContainerView.rightAnchor, bottom: self.headerContainerView.bottomAnchor, left: self.headerContainerView.leftAnchor, paddingRight: 16,paddingBottom: 20, paddingLeft: 16)
        }
        self.headerContainerView.addSubview(avatarImageView) {
            self.avatarImageView.setAnchor(right: self.headerContainerView.rightAnchor, bottom: self.searchBar.topAnchor,paddingRight: 24 , paddingBottom: 20)
        }
        
        self.scrollView.addSubview(collectionView) {
            self.collectionView.setAnchor(top: self.headerContainerView.bottomAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor, paddingTop: 20)
        }
    }
    
    // MARK: - Collection View Configuration
    
    func configureCollectionView() {
        
        let collectionViewLayout = UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in
            var item: NSCollectionLayoutItem!
            var group: NSCollectionLayoutGroup!
            var section: NSCollectionLayoutSection!
            let sectionTitleSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: SectionTitleView.kind, alignment: .topLeading)
            
            if sectionIndex == CollectionViewSection.trendings.rawValue {
                
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(110)), subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets.trailing = 8
            } else {
                
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(165), heightDimension: .estimated(190)), subitems: [item])
                
                
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
    
    func configureCollectionViewSectionTitleView() {
        collectionViewDataSource?.supplementaryViewProvider = .some({ (collectionview, kind, indexPath) -> UICollectionReusableView? in
            guard let titleView = collectionview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleView.identifier, for: indexPath) as? SectionTitleView else {return UICollectionReusableView()}
            
            switch indexPath.section {
                case CollectionViewSection.trendings.rawValue:
                    titleView.title = "Trendings"
                    titleView.linkType = .empty
                case CollectionViewSection.nearby.rawValue:
                    titleView.title = "Nearby"
                    titleView.linkType = .seeOnMap
                case CollectionViewSection.rating.rawValue:
                    titleView.title = "Highest Rating"
                    titleView.linkType = .seeAll
                default:
                    titleView.title = "Merchants"
            }
            
            return titleView
        })
    }
    
    func configureCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionview, indexPath, merchant) -> UICollectionViewCell? in

            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MerchantCollectionCell.identifier, for: indexPath) as? MerchantCollectionCell else {return UICollectionViewCell()}
            cell.data = merchant

            if indexPath.section == CollectionViewSection.trendings.rawValue {
                cell.rankLabel.text = "\(indexPath.row+1)"
                cell.configureTrendingCell()
            } else {
                cell.configureMerchantCell()
            }
            
            return cell

        }
    }
    
    func configureCollectionViewSnapshot() {
        collectionViewSnapshot = MainCollectionSnapshot()
        collectionViewSnapshot!.appendSections([.nearby,.rating,.trendings])
        collectionViewSnapshot!.appendItems(exploreDessert, toSection: .trendings)
        collectionViewSnapshot!.appendItems(nearbyMerchants, toSection: .nearby)
        collectionViewSnapshot!.appendItems(highestRatingMerchants, toSection: .rating)
        collectionViewDataSource?.apply(collectionViewSnapshot!, animatingDifferences: true, completion: nil)
    }

}

// MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let merchant = collectionViewDataSource?.itemIdentifier(for: indexPath)
        print("SELECTED MERCHANT : \(merchant!.name)")
    }
}


