//
//  SearchResultView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 26/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class SearchResultView: UIView {
    
    static let height = (UIScreen.main.bounds.height - MainHeaderView.height) + 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
