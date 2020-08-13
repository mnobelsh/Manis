//
//  MerchantDetailView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 04/08/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

protocol MerchantDetailViewDelegate {
    func getDirectionToSelectedMerchant(_ routeInfo: MerchantRoute)
    func hideMerchantDetailView()
}

class MerchantDetailView: UIView {
    
    static let detailViewHeight: CGFloat = 300
    static let directionViewHeight: CGFloat = 150
    
    var merchantDetails: MerchantRoute? {
        didSet {
            guard let merchant = merchantDetails?.merchant else {return}
            guard let route = merchantDetails?.route else {return}
            
            merchantNameLabel.text = merchant.name
            
            let distance = merchant.location.distance(from: LocationHandler.shared.manager.location!).rounded()/1000
            distanceLabel.text = String(format: "%.2f Km", distance)
            
            addressLabel.text = merchant.address
            
            let estimatedTime = Int(route.expectedTravelTime.rounded()) / 60
            estimatedTimeLabel.text = estimatedTime < 3 ? "Less than 3 Minutes" : "\(estimatedTime) Minutes"
            
        }
    }
    
    var delegate: MerchantDetailViewDelegate?
    private lazy var getDirectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.configureButton(title: "Start", titleColor: .black, backgroundColor: .systemTeal, cornerRadius: 12)
        button.setSize(height: 50)
        button.addTarget(self, action: #selector(getDirectionButtonDidTap), for: .touchUpInside)
        return button
    }()
    private lazy var endDirectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.configureButton(title: "End", titleColor: .black, backgroundColor: .systemPink, cornerRadius: 12)
        button.setSize(height: 50)
        button.addTarget(self, action: #selector(endDirectionButtonDidTap), for: .touchUpInside)
        return button
    }()
    private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 12)
        view.configureShadow(shadowColor: .lightGray, radius: 6)
        return view
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setSize(width: 35, height: 35)
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    private var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Merchant's Name", fontSize: 20, textColor: .black)
        label.numberOfLines = 0
        return label
    }()
    private var distanceLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Distance", fontSize: 18, textColor: .darkGray)
        label.setSize(width: 75)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.configureTextLabel(title: "Distance", fontSize: 16, textColor: .darkGray)
        label.setSize(height: 50)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Rating", fontSize: 16, textColor: .black)
        label.setSize(width: 50)
        label.textAlignment = .left
        return label
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.configureRatingView(ratingLabel: ratingLabel)
        return view
    }()
    private var estimatedTimeLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Estimated Time", fontSize: 16, textColor: .darkGray)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureMerchantDetailView() {
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.backgroundColor = .clear
        self.addSubview(mainView) {
            self.mainView.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 50)
        }
        
        self.addSubview(backButton) {
            self.backButton.setAnchor(bottom: self.mainView.topAnchor, left: self.leftAnchor,paddingBottom: 8, paddingLeft: 16)
        }
        
        self.mainView.addSubview(distanceLabel) {
            self.distanceLabel.setAnchor(top: self.mainView.topAnchor, right: self.mainView.rightAnchor, paddingTop: 26, paddingRight: 16)
        }
        
        self.mainView.addSubview(merchantNameLabel) {
            self.merchantNameLabel.setAnchor(top: self.mainView.topAnchor, right: self.distanceLabel.leftAnchor, left: self.mainView.leftAnchor, paddingTop: 26, paddingRight: 8, paddingLeft: 16)
        }
        
        self.mainView.addSubview(addressLabel) {
            self.addressLabel.setAnchor(top: self.merchantNameLabel.bottomAnchor, right: self.merchantNameLabel.rightAnchor, left: self.mainView.leftAnchor, paddingTop: 8, paddingLeft: 16)
        }
        
        self.mainView.addSubview(ratingView) {
            self.ratingView.setAnchor(top: self.addressLabel.bottomAnchor, left: self.mainView.leftAnchor, paddingTop: 8, paddingLeft: 16)
        }
        
        self.mainView.addSubview(getDirectionButton) {
            self.getDirectionButton.setAnchor(right: self.mainView.rightAnchor, bottom: self.mainView.bottomAnchor, paddingRight: 16, paddingBottom: 32)
            self.getDirectionButton.setSize(width: 170)
        }
        
        self.mainView.addSubview(estimatedTimeLabel) {
            self.estimatedTimeLabel.setCenterYAnchor(in: self.getDirectionButton)
            self.estimatedTimeLabel.setAnchor(right: self.getDirectionButton.leftAnchor, left: self.mainView.leftAnchor, paddingRight: 8, paddingLeft: 16)
        }
    }
    
    func configureDirectionView() {
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        self.configureRoundedCorners(corners: [.topLeft,.topRight], radius: 12)
        self.backgroundColor = .systemBackground
        
        self.addSubview(endDirectionButton) {
            self.endDirectionButton.setAnchor(right: self.rightAnchor, paddingRight: 16)
            self.endDirectionButton.setCenterXYAnchor(in: self)
            self.endDirectionButton.setSize(width: 170)
        }

        self.addSubview(estimatedTimeLabel) {
            self.estimatedTimeLabel.setCenterXYAnchor(in: self)
            self.estimatedTimeLabel.setAnchor(right: self.endDirectionButton.leftAnchor, left: self.leftAnchor, paddingRight: 8, paddingLeft: 16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func getDirectionButtonDidTap() {
        delegate?.getDirectionToSelectedMerchant(merchantDetails!)
    }
    
    @objc private func endDirectionButtonDidTap() {
        delegate?.hideMerchantDetailView()
    }
    
    @objc private func backButtonDidTap() {
        delegate?.hideMerchantDetailView()
    }
    
}
