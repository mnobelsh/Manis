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

enum MerchantListType: String {
    case highRating = "High Rating", favorites = "Your Favorites"
}

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
    
    private let service = FirebaseService.shared
    private var merchantList: [Merchant] = [Merchant]() {
        didSet {
            self.updateSnapshot(data: self.merchantList)
        }
    }
    
    var merchantListType: MerchantListType? {
        didSet {
            self.fetchMerchants(fetchType: merchantListType!, merchantLimit: 16)
        }
    }
    
    var merchantVC: MerchantViewController?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let mainVC = navigationController?.viewControllers.first as? MainViewController else {return}
        mainVC.hideNavbar()
//        guard let merchantVC = merchantVC else {return}
//        merchantVC.configureNavbar()
    }

    // MARK: - Helpers
    
    func configureCollectionView() {
        configureDataSource()
        configureSnapshot()
    }
    
    private func configureUI() {
        title = self.merchantListType!.rawValue
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = false
        self.setTransparentNavbar()
        self.view.addSubview(merchantsCollectionView) {
            self.merchantsCollectionView.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor)
        }
    }
    
    private func configureDataSource() {
        merchantListDataSource = MerchantListDataSource(collectionView: self.merchantsCollectionView, cellProvider: { (collectionview, indexPath, merchant) -> UICollectionViewCell? in
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MerchantCollectionCell.identifier, for: indexPath) as? MerchantCollectionCell else {return UICollectionViewCell()}
            cell.data = merchant
            cell.configureMerchantCell()
            return cell
        })
    }
    
    private func configureSnapshot() {
        merchantListSnapshot = MerchantListSnapshot()
        merchantListSnapshot.appendSections([.main])
        merchantListDataSource.apply(merchantListSnapshot, animatingDifferences: true, completion: nil)
    }
    
    private func updateSnapshot(data: [Merchant]) {
        merchantListSnapshot.appendItems(data, toSection: .main)
        merchantListDataSource.apply(merchantListSnapshot, animatingDifferences: true, completion: nil)
    }
    
    private func fetchMerchants(fetchType type: MerchantListType, merchantLimit limit: Int) {
        switch type {
            case .favorites:
                print("MERCHANTS :FAVORITES LIST")
            case .highRating:
                service.fetchHighRatingMerchants(limitMerchants: limit) { (merchant) in
                    self.merchantList.append(merchant)
                }
        }
    }


}

// MARK: - Collection View Delegate
extension MerchantListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        merchantVC = MerchantViewController()
        merchantVC!.merchant = self.merchantListDataSource.itemIdentifier(for: indexPath)
        self.navigationController?.pushViewController(merchantVC!, animated: true)
    }
    
}
