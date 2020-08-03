//
//  MerchantListViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 28/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

typealias MerchantListDataSource = UICollectionViewDiffableDataSource<MerchantListCollectionViewSection, Merchant>
typealias MerchantListSnapshot = NSDiffableDataSourceSnapshot<MerchantListCollectionViewSection, Merchant>

class MerchantListViewController: UIViewController {

    // MARK: - Properties
    private lazy var merchantsCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configureMerchantListCollectionViewLayout())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.register(MerchantCollectionCell.self, forCellWithReuseIdentifier: MerchantCollectionCell.identifier)
        return cv
    }()
    private var merchantListDataSource: MerchantListDataSource!
    private var merchantListSnapshot: MerchantListSnapshot!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureSnapshot()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = navigationController?.viewControllers.first as? MainViewController else {return}
        vc.hideNavbar()
    }

    // MARK: - Helpers
    private func configureUI() {
        title = "Highest Rating"
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = false
        self.view.addSubview(merchantsCollectionView) {
            self.merchantsCollectionView.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor)
        }
    }
    
    private func configureDataSource() {
        merchantListDataSource = MerchantListDataSource(collectionView: self.merchantsCollectionView, cellProvider: { (collectionview, indexPath, merchant) -> UICollectionViewCell? in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MerchantCollectionCell.identifier, for: indexPath) as? MerchantCollectionCell else {return UICollectionViewCell()}
            
            cell.configureMerchantCell()
            return cell
        })
    }
    
    private func configureSnapshot() {
        merchantListSnapshot = MerchantListSnapshot()
        merchantListSnapshot.appendSections([.main])
        merchantListSnapshot.appendItems(Merchant.highestRatingAllMerchants, toSection: .main)
        merchantListDataSource.apply(merchantListSnapshot, animatingDifferences: true, completion: nil)
    }


}

// MARK: - Collection View Delegate
extension MerchantListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
