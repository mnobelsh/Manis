//
//  UIHelper.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 22/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

enum MainCollectionViewSection: Int {
    case trendings = 2, nearby = 0, rating = 1
}

enum MerchantListCollectionViewSection: Int {
    case main = 0
}

func configureMainCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in
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
}

func configureMerchantListCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in
        var item: NSCollectionLayoutItem!
        var group: NSCollectionLayoutGroup!
        var section: NSCollectionLayoutSection!
        
        item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        let smallGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(260)), subitem: item, count: 2)
        
        group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [smallGroup])
        
        section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
}


