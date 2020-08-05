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

enum Sections: Int {
    case main = 0
}

func configureReviewCollectionViewLayout() ->UICollectionViewCompositionalLayout { return UICollectionViewCompositionalLayout { (section,env) -> NSCollectionLayoutSection? in
        var item: NSCollectionLayoutItem!
        var group: NSCollectionLayoutGroup!
        print("DEBUGS : While Set up Layout")

        if section == Sections.main.rawValue {
            //ITEM
            item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            //GROUP
            group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330)), subitems: [item])
            
            print("DEBUGS LAYOUT MASUL")
        } else {
            print("Layout ga masuk!")
        }
        
        
        //SECTION
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 8

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

//enum MerchantCVSection: Int {
//    case priceRanges = 0, badges = 1, menus = 2,photos = 3, reviews = 4
//}
//
//func configMerchantCVLayout() -> UICollectionViewCompositionalLayout {
//    return UICollectionViewCompositionalLayout { (sectidx, envs)-> NSCollectionLayoutSection? in
//        var items: NSCollectionLayoutItem!
//        var groups: NSCollectionLayoutGroup!
//        var sections: NSCollectionLayoutSection!
//
//        //sect Title
//        let sectionTitleSupplementaryitems = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: SectTitleView.kind, alignment: .topLeading)
//        //sect Content
//        if sectidx == MerchantCVSection.priceRanges.rawValue {
//            items = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//            groups = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), subitems: [items])
//
//            groups.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//
//            sections = NSCollectionLayoutSection(group: groups)
//            sections.contentInsets.trailing = 8
//        } else if sectidx == MerchantCVSection.badges.rawValue {
//            items = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//            groups = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(84), heightDimension: .absolute(130)), subitems: [items])
//
//            groups.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//
//            sections = NSCollectionLayoutSection(group: groups)
//            sections.contentInsets.trailing = 8
//        } else if sectidx == MerchantCVSection.menus.rawValue {
//            items = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//            groups = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130)), subitems: [items])
//
//            groups.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//
//            sections = NSCollectionLayoutSection(group: groups)
//            sections.contentInsets.trailing = 8
//        } else if sectidx == MerchantCVSection.photos.rawValue {
//            items = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//
//            groups = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(151), heightDimension: .absolute(151)), subitems: [items])
//
//            groups.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//
//            sections = NSCollectionLayoutSection(group: groups)
//            sections.orthogonalScrollingBehavior = .continuous
//        } else {
//            items = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//            items.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//
//            //GROUP
//            groups = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(330)), subitems: [items])
//
//            sections = NSCollectionLayoutSection(group: groups)
//            sections.contentInsets.trailing = 8
//        }
//
//        sections.contentInsets.top = 8
//         sections.contentInsets.leading = 8
//         sections.contentInsets.bottom = 15
//        sections.boundarySupplementaryItems = [sectionTitleSupplementaryitems]
//
//         return sections
//    }
//}


