//
//  SearchResultView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 26/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

enum SearchResultTableViewSection {
    case result
}

class SearchResultView: UIView {
    
    // MARK: - Propertis
    static let height = (UIScreen.main.bounds.height - MainHeaderView.height) + 10
    var resultTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.allowsSelection = true
        tv.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        return tv
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        self.addSubview(resultTableView) {
            self.resultTableView.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 16, paddingRight: 16, paddingLeft: 16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureTableView(delegate: UITableViewDelegate? = nil, dataSource: UITableViewDataSource? = nil) {
        self.resultTableView.delegate = delegate
        self.resultTableView.dataSource = dataSource
    }
    
    
}
