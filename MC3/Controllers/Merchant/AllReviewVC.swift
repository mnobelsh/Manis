//
//  AllReviewVC.swift
//  MC3
//
//  Created by Muhammad Thirafi on 24/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

enum Sections: Int {
    case main = 0
}

typealias CollectionDataSource = UICollectionViewDiffableDataSource<Sections,Review>
typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Sections,Review>

class AllReviewVC: UIViewController {
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "Add Review", titleColor: .black, backgroundColor: UIColor(hexString: "9CE4E5"), cornerRadius: 8)
        button.setSize(width: 170, height: 50)
        return button
    }()
    
    private var reviewDetails: [Review] =
        [Review(id: UUID().uuidString, userName: "Bambang"),
         Review(id: UUID().uuidString, userName: "Nobal"),
         Review(id: UUID().uuidString, userName: "Sukma"),
         Review(id: UUID().uuidString, userName: "kamu"),
         Review(id: UUID().uuidString, userName: "I"),
         Review(id: UUID().uuidString, userName: "Hate"),
         Review(id: UUID().uuidString, userName: "U")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionViews()
        
        view.addSubview(addButton){
            self.addButton.setCenterXAnchor(in: self.view)
            self.addButton.setAnchor( bottom: self.view.bottomAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 25, paddingLeft: 8)
        }
    }
    
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: CollectionDataSource?

    func configureCollectionViews(){
        let collectionViewLayout = UICollectionViewCompositionalLayout { (section,env) -> NSCollectionLayoutSection? in
            var item: NSCollectionLayoutItem!
            var group: NSCollectionLayoutGroup!
            
            if section == Sections.main.rawValue {
                //ITEM
                item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                //GROUP
                group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330)), subitems: [item])
            } else {
                print("Layout ga masuk!")
            }
            
            
            //SECTION
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.top = 8
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(ReviewCollectionViewCells.self, forCellWithReuseIdentifier: ReviewCollectionViewCells.identifier)
        
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionview, indexPath, review) -> UICollectionViewCell? in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCells.identifier, for: indexPath) as? ReviewCollectionViewCells else {return UICollectionViewCell()}
            cell.details = review
//            indexPath.section == Sections.main.rawValue ? cell.configureCells() : cell.configureCells()
            cell.configureCells()
            return cell
        }
        
        configureCollectionViewSnapshot()
        
        self.view.addSubview(collectionView) {
            self.collectionView.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.rightAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, left: self.view.leftAnchor)
        }

    }
    
    func configureCollectionViewSnapshot() {
        var Snappy = CollectionSnapshot()
        Snappy.appendSections([.main])
        Snappy.appendItems(reviewDetails, toSection: .main)
        collectionViewDataSource?.apply(Snappy, animatingDifferences: true, completion: nil)
    }
    
}

extension AllReviewVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = collectionViewDataSource?.itemIdentifier(for: indexPath)
            print("SELECTED Review : \(review!.userName)")
        }
    }

