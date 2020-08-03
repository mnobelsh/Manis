//
//  NearbyMerchantListView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 29/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class NearbyMerchantListView: UIView {
    
    // MARK: - Properties
    static let height: CGFloat = 250
    
    var nearbyMerchantsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(MerchantTableCell.self, forCellReuseIdentifier: MerchantTableCell.identifier)
        return tableView
    }()
    private let indicatorBar: UIView = {
        let view = UIView()
        view.setSize(width: 80, height: 4)
        view.backgroundColor = .lightGray
        view.configureRoundedCorners(corners: [.allCorners], radius: 2)
        return view
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        self.backgroundColor = .systemBackground
        self.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 12)
        self.configureShadow(shadowColor: .lightGray, radius: 4)
        
        self.addSubview(indicatorBar) {
            self.indicatorBar.setAnchor(top: self.topAnchor, paddingTop: 12)
            self.indicatorBar.setCenterXAnchor(in: self)
        }
        
        self.addSubview(self.nearbyMerchantsTableView) {
            self.nearbyMerchantsTableView.setAnchor(top: self.indicatorBar.bottomAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 16)
        }
    }
    
    func configureTableView(delegate: UITableViewDelegate? = nil, dataSource: UITableViewDataSource? = nil) {
        self.nearbyMerchantsTableView.delegate = delegate
        self.nearbyMerchantsTableView.dataSource = dataSource
    }
    
    
    
}
