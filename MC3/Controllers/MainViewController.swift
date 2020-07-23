//
//  HomeViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

enum CollectionViewSection: Int {
    case explore = 0, nearby = 1, rating = 2
}
typealias MainCollectionDataSource = UICollectionViewDiffableDataSource<CollectionViewSection,Merchant>
typealias MainCollectionSnapshot = NSDiffableDataSourceSnapshot<CollectionViewSection,Merchant>

class MainViewController: UIViewController {
    
    private var exploreDessert: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Doger"),
                                              Merchant(id: UUID().uuidString, name: "Es Campur"),
                                              Merchant(id: UUID().uuidString, name: "Es Goyobod")]
    private var nearbyMerchants: [Merchant] =  [Merchant(id: UUID().uuidString, name: "Es Cincau Mang Ucup"),
                                                Merchant(id: UUID().uuidString, name: "Es Teler Uhuy"),
                                                Merchant(id: UUID().uuidString, name: "Es Pisang Ijo Prikitiew")]
    private var highestRatingMerchants: [Merchant] = [Merchant(id: UUID().uuidString, name: "Es Puter Linlin"),
                                                      Merchant(id: UUID().uuidString, name: "Es Slendang Mayang Sari"),
                                                      Merchant(id: UUID().uuidString, name: "Es Bahenol")]
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: MainCollectionDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        let collectionViewLayout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            var item: NSCollectionLayoutItem!
            var group: NSCollectionLayoutGroup!
            
            if section == CollectionViewSection.explore.rawValue {
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(180), heightDimension: .absolute(100)), subitems: [item])
                
            } else {
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(175), heightDimension: .fractionalHeight(0.35)), subitems: [item])
            }
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 15
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        self.collectionView.register(MerchantCollectionCell.self, forCellWithReuseIdentifier: MerchantCollectionCell.identifier)
        
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionview, indexPath, merchant) -> UICollectionViewCell? in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MerchantCollectionCell.identifier, for: indexPath) as? MerchantCollectionCell else {return UICollectionViewCell()}
            cell.data = merchant
            indexPath.section == CollectionViewSection.explore.rawValue ? cell.configureSmallCell() : cell.configureLargeCell()
            return cell
        }
    
        configureCollectionViewSnapshot()
        
        self.view.addSubview(collectionView) {
            self.collectionView.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.rightAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, left: self.view.leftAnchor)
        }
    }
    
    func configureCollectionViewSnapshot() {
        var snapshot = MainCollectionSnapshot()
        snapshot.appendSections([.explore,.nearby,.rating])
        snapshot.appendItems(exploreDessert, toSection: .explore)
        snapshot.appendItems(nearbyMerchants, toSection: .nearby)
        snapshot.appendItems(highestRatingMerchants, toSection: .rating)
        collectionViewDataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }

}

// MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let merchant = collectionViewDataSource?.itemIdentifier(for: indexPath)
        print("SELECTED MERCHANT : \(merchant!.name)")
    }
}
