//
//  MainHeaderView.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 25/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import CoreLocation

protocol MainHeaderViewDelegate {
    func avatarDidTapped()
    func locationDidChanged(locationLabel: UILabel)
    func hideSearchHeaderView()
}


class MainHeaderView: UIView {
    
    // MARK: - Properties
    var delegate: MainHeaderViewDelegate?
    static let height: CGFloat = 200
    
    var user: User? {
        didSet {
            self.avatarImageView.configureAvatarView(avatarImage: UIImage(named: user!.profilePicture), dimension: 65)
            self.locationLabel.text = "Location"
        }
    }
    var placeMark: CLPlacemark? {
        didSet {
            self.locationLabel.text = placeMark?.locality
        }
    }
    
    private lazy var avatarImageView: AvatarImageView = {
        let avatarImage = AvatarImageView(frame: .zero)
        avatarImage.configureAvatarView(avatarImage: #imageLiteral(resourceName: "profile"), dimension: 65)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarImageTapped))
        avatarImage.addGestureRecognizer(tapGesture)
        return avatarImage
    }()
    lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.autocapitalizationType = .none
        searchbar.autocorrectionType = .no
        searchbar.backgroundColor = .clear
        searchbar.searchBarStyle = .minimal
        searchbar.placeholder = "Search"
        
        return searchbar
    }()
    private var mappinImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "UserLocation"))
        imageView.contentMode = .scaleAspectFit
        imageView.setSize(width: 24, height: 30)
        return imageView
    }()
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.configureHeadingLabel(title: "Kemanggisan", textColor: .black)
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationLabelTapped))
        label.addGestureRecognizer(tapGesture)
        
        return label
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        button.setSize(width: 24, height: 24)
        button.addTarget(self, action: #selector(hideSearchHeader), for: .touchUpInside)
        return button
    }()

    var isSearchViewHidden: Bool = true {
        didSet {
            self.configureSearchViewHeader()
        }
    }
    lazy var sortingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 24, bottom: .zero, right: 24)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(SortingCollectionViewCell.self, forCellWithReuseIdentifier: SortingCollectionViewCell.identifier)
        
        return cv
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(avatarImageView) {
            self.avatarImageView.setAnchor(top: self.safeAreaLayoutGuide.topAnchor, right: self.rightAnchor, paddingTop: 10, paddingRight: 24)
        }
        self.addSubview(mappinImageView) {
            self.mappinImageView.setAnchor(bottom: self.avatarImageView.bottomAnchor, left: self.leftAnchor, paddingLeft: 16)
        }
        self.addSubview(locationLabel) {
            self.locationLabel.setAnchor(right: self.avatarImageView.leftAnchor, bottom: self.mappinImageView.bottomAnchor, left: self.mappinImageView.rightAnchor, paddingRight: 16, paddingLeft: 8)

        }
        self.addSubview(searchBar) {
            self.searchBar.frame = CGRect(x: 16, y: self.frame.height - 55, width: self.frame.width - 32, height: 45)
        }
        self.addSubview(backButton) {
            self.backButton.setAnchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 16)
            self.backButton.alpha = 0
        }
        self.addSubview(sortingCollectionView) {
            self.sortingCollectionView.setAnchor(top: self.searchBar.bottomAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 8, paddingBottom: 8)
            self.sortingCollectionView.alpha = 0
        }
        
        self.backgroundColor = .white
        self.configureRoundedCorners(corners: [.bottomRight,.bottomLeft], radius: 12)
        self.configureShadow(shadowColor: .lightGray, radius: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureSearchViewHeader() {

        if isSearchViewHidden {
            UIView.animate(withDuration: 0.3) {
                self.avatarImageView.alpha = 1
                self.mappinImageView.alpha = 1
                self.locationLabel.alpha = 1
                self.backButton.alpha = 0
                self.sortingCollectionView.alpha = 0
                self.searchBar.frame.origin.y = self.frame.height - (10 + self.searchBar.frame.height)
            }
        
        } else  {
            UIView.animate(withDuration: 0.3) {
                self.avatarImageView.alpha = 0
                self.mappinImageView.alpha = 0
                self.locationLabel.alpha = 0
                self.backButton.alpha = 1
                self.sortingCollectionView.alpha = 1
                self.searchBar.frame.origin.y = self.backButton.frame.height + 60
            }
        }
    }
    
    func configureCollectionView(delegate : UICollectionViewDelegate? = nil, dataSource: UICollectionViewDataSource? = nil) {
        self.sortingCollectionView.delegate = delegate
        self.sortingCollectionView.dataSource = dataSource
    }
    
    func configureSearchBar(delegate : UISearchBarDelegate) {
        self.searchBar.delegate = delegate
    }
        
    private func resetSearchAppereance() {
        resetSortingCellAppereance()
        self.searchBar.text?.removeAll()
    }
    
    func resetSortingCellAppereance() {
        self.sortingCollectionView.subviews.forEach { (view) in
            guard let cell = view as? SortingCollectionViewCell else {return}
            cell.backgroundColor = .systemBackground
            cell.setLabelColorContrastToBackground()
        }
    }
    
    // MARK: - Targets
    @objc private func avatarImageTapped() {
        delegate?.avatarDidTapped()
    }
    
    @objc private func locationLabelTapped() {
        delegate?.locationDidChanged(locationLabel: self.locationLabel)
    }
    
    @objc private func hideSearchHeader() {
        delegate?.hideSearchHeaderView()
        resetSearchAppereance()
    }
    
}
