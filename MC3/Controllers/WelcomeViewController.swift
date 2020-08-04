//
//  WelcomeViewController.swift
//  MC3
//
//  Created by Melina Dewi on 28/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {
        
    let scrollView = UIScrollView()
    let titles = ["Gives you information about traditional ice around you", "Guide you to the destination", "Give review and see other’s review"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUpBottomControls()
        view.backgroundColor = .white
    }
    
    private lazy var skipButton: UIButton = {
        let skipButton = UIButton()
        skipButton.setTitleColor(.systemBlue, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        skipButton.addTarget(self, action: #selector(didTapSkipButton(_:)), for: .touchUpInside)
        
        return skipButton
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.configureRoundedCorners(corners: [.allCorners], radius: 12)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.51, green: 0.85, blue: 0.82, alpha:1)
        button.setTitle("Next", for: .normal)
        button.setSize(width: 170, height: 50)
        button.configureShadow(shadowColor: .gray, radius: 3)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        
        return button
    }()

    private func configure() {
        
        scrollView.frame = view.frame
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        for i in 0..<titles.count {
            let pageView = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            scrollView.addSubview(pageView)

            let imageView = UIImageView(frame: CGRect(x: 0, y: pageView.frame.size.height/4, width: pageView.frame.size.width, height: pageView.frame.size.height/3))
            
            let titleLabel = UILabel(frame: CGRect(x: 50, y: 50, width: pageView.frame.size.width - 100, height: 120))
            
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
            titleLabel.numberOfLines = 2
            pageView.addSubview(titleLabel)
            titleLabel.text = titles[i]
            
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "onboarding\(i+1)")
            pageView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.addSubview(pageControl)
        pageControl.layer.zPosition = 1
        view.addSubview(pageControl)
        
        view.addSubview(skipButton)
        skipButton.setAnchor(top: self.view.topAnchor, right: self.view.rightAnchor, paddingTop: 50, paddingRight: 10)
        skipButton.setSize(width: 85, height: 40)
        
        view.addSubview(nextButton)
        nextButton.setCenterXAnchor(in: view)
        nextButton.setAnchor(top: pageControl.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, paddingTop: 30, paddingRight: 100, paddingLeft: 100)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset[0].x / view.frame.size.width)
        if pageControl.currentPage < 2 {
            self.nextButton.setTitle("Next", for: .normal)
            self.skipButton.isHidden = false
        } else {
            self.nextButton.setTitle("Get Started", for: .normal)
            self.skipButton.isHidden = true
        }
    }
    
    @objc func didTapButton(_ button:UIButton) {
        if pageControl.currentPage < 2 {
            pageControl.currentPage = pageControl.currentPage + 1
            for view in self.view.subviews {
                if let scrollView = view as? UIScrollView {
                    scrollView.setContentOffset(CGPoint(x: view.frame.size.width * CGFloat(pageControl.currentPage), y: scrollView.contentOffset.y), animated: true)
                }
            }
            if pageControl.currentPage == 2 {
                button.setTitle("Get Started", for: .normal)
                self.skipButton.isHidden = true
            }
        } else {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
    @objc func didTapSkipButton(_ button:UIButton) {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor(red: 0.51, green: 0.85, blue: 0.82, alpha:1)
        pc.pageIndicatorTintColor = UIColor(red: 0.51, green: 0.85, blue: 0.82, alpha: 0.5)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    fileprivate func setUpBottomControls() {
        NSLayoutConstraint.activate([pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor), pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -250)])
    }
        
}
