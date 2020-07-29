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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
        setUpBottomControls()
    }

    private func configure() {
        scrollView.frame = view.frame
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        let titles = ["Gives you information about traditional ice around you", "Guide you to the destination", "Give review and see other’s review"]
        for i in 0..<titles.count {
            let pageView = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            scrollView.addSubview(pageView)
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: pageView.frame.size.height/4, width: pageView.frame.size.width, height: pageView.frame.size.height/3))
            
            let titleLabel = UILabel(frame: CGRect(x: 50, y: 50, width: pageView.frame.size.width - 100, height: 120))
            
            let button = UIButton(frame: CGRect(x: 75, y: pageView.frame.size.height - 250, width: pageView.frame.size.width - 150, height: 50))
            
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
            titleLabel.numberOfLines = 2
            pageView.addSubview(titleLabel)
            titleLabel.text = titles[i]
            
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "onboarding\(i+1)")
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.51, green: 0.85, blue: 0.82, alpha:1)
            
            if i == titles.count - 1 {
                button.setTitle("Get Started", for: .normal)
            } else {
                button.setTitle("Next", for: .normal)
            }
            button.titleLabel?.font = UIFont(name: "Avenir", size: 22)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = i+1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.addSubview(pageControl)
        pageControl.layer.zPosition = 1
        view.addSubview(pageControl)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset[0].x / view.frame.size.width)
    }
    
    @objc func didTapButton(_ button:UIButton) {
        if pageControl.currentPage < 2 {
            pageControl.currentPage = pageControl.currentPage + 1
        }
        scrollView.setContentOffset(CGPoint(x: view.frame.size.width * CGFloat(button.tag), y: scrollView.contentOffset.y), animated: true)
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
        NSLayoutConstraint.activate([pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor), pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100)])
    }
        
}
