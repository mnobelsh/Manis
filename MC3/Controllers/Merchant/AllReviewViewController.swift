////
////  AllReviewViewController.swift
////  MC3
////
////  Created by Muhammad Nobel Shidqi on 21/07/20.
////  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
////
//
//import UIKit
//
//enum section {
//    case main
//}
//typealias DataSource = UICollectionViewDiffableDataSource<section, Review>
//typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<section, Review>
//
//class AllReviewViewController: UIViewController {
////
////    private var reviewDetailsData: [Review] = [Review(id: UUID().uuidString, userName: "SIbambank", rate:UIImage(systemName: "star.fill"), badge:
////            UIImage(systemName: "hand.thumbsdown.fill"), details: "Nda enak"),
////            Review(id: UUID().uuidString, userName: "Nobal", rate: UIImage(systemName: "star.fill"), badge: UIImage(systemName: "hand.thumbsup.fill"), details: "WUEENAK"),
////    Review(id: UUID().uuidString, userName: "Nobal", rate: UIImage(systemName: "star.fill"), badge: UIImage(systemName: "hand.thumbsup.fill"), details: "WUEENAK"),
////    Review(id: UUID().uuidString, userName: "Nobal", rate: UIImage(systemName: "star.fill"), badge: UIImage(systemName: "hand.thumbsup.fill"), details: "WUEENAK")]
//    
//    private var collectionView: UICollectionView!
//    private var collectionViewDataSource: DataSource?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        configureCollectionView()
//    }
//    
//    func configureCollectionView(){
//        let collectionViewLayout = UICollectionViewCompositionalLayout {
//            (section,env) -> NSCollectionLayoutSection? in
//            var item: NSCollectionLayoutItem!
//            var group: NSCollectionLayoutGroup!
//            
//            item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//            
//            group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(200), heightDimension: .absolute(200)), subitems: [item])
//            
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets.top = 15
//            section.orthogonalScrollingBehavior = .continuous
//            return section
//        }
//        
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collectionView.backgroundColor = .clear
//        collectionView.delegate = self
//        self.collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
//        
//        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { ( collectionview, indexPath, review) -> UICollectionViewCell? in
//            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
//            cell.data = review
//            return cell
//        }
//        
//        createSnapShot()
//        
//        self.view.addSubview(collectionView){
//            self.collectionView.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.rightAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, left: self.view.leftAnchor)
//        }
//        
//    }
//    
//    func createSnapShot(){
//        var snapShot = DataSourceSnapshot()
//        snapShot.appendSections([.main])
////        snapShot.appendItems(reviewDetailsData, toSection: .main)
//        collectionViewDataSource?.apply(snapShot, animatingDifferences: true, completion: nil)
//    }
//}
//
//// MARK: - Collection View Delegate
//extension AllReviewViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let review = collectionViewDataSource?.itemIdentifier(for: indexPath)
//        print("SELECTED MERCHANT : \(review!.userName)")
//    }
//}
//
//
