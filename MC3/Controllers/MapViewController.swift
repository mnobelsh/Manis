//
//  MapViewController.swift
//  MC3
//
//  Created by Muhammad Nobel Shidqi on 21/07/20.
//  Copyright © 2020 Muhammad Nobel Shidqi. All rights reserved.
//

import UIKit
import MapKit


typealias NearbyTableViewDataSource = UITableViewDiffableDataSource<MerchantTableViewSection, Merchant>
typealias NearbyTableViewSnapshot = NSDiffableDataSourceSnapshot<MerchantTableViewSection, Merchant>

class MapViewController: UIViewController {

    // MARK: - Properties
    private lazy var mapView: MKMapView = {
        let mapview = MKMapView()
        mapview.showsUserLocation = true
        mapview.frame = self.view.bounds
        mapview.delegate = self
        return mapview
    }()
    private var locationHandler = LocationHandler.shared
    private var nearbyMerchantListView = NearbyMerchantListView()
    
    private var nearbyTableViewDataSource: NearbyTableViewDataSource?
    private var nearbyTableViewSnapshot: NearbyTableViewSnapshot?
    
    
    var nearbyMearchants = [Merchant]()
    
    private let service = FirebaseService.shared
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNearbyMerchantListView()
        configureMerchantAnnotation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.nearbyMerchantListView.frame.origin.y = self.view.frame.height - NearbyMerchantListView.height
        }, completion: nil)
        
        print("annos : \(self.mapView.annotations.count)")
        zoomRect(annotations: self.mapView.annotations, width: 0.1, height: 0.1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let vc = navigationController?.viewControllers.first as? MainViewController else {return}
        vc.hideNavbar()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.nearbyMerchantListView.alpha = 0
        }, completion: nil)
    }
    
    // MARK: - Helpers
    private func configureNavbar() {
        self.navigationController?.navigationBar.isHidden = false
        self.setTransparentNavbar()
    }
    
    private func configureUI() {
        configureNavbar()
        
        self.view.addSubview(mapView) {
            self.mapView.setAnchor(top: self.view.topAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, left: self.view.leftAnchor)
        }
        
        self.nearbyMerchantListView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: NearbyMerchantListView.height)

    }
    
    private func configureNearbyMerchantListView() {
        self.mapView.addSubview(nearbyMerchantListView)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeView(_:)))
        swipeDownGesture.direction = .down
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeView(_:)))
        swipeUpGesture.direction = .up
        
        self.nearbyMerchantListView.addGestureRecognizer(swipeDownGesture)
        self.nearbyMerchantListView.addGestureRecognizer(swipeUpGesture)
        
        nearbyMerchantListView.configureTableView(delegate: self)
        configureTableViewDataSource()
        configureTableViewSnapshot()
    }
    
    private func configureTableViewDataSource() {
        let tableView = nearbyMerchantListView.nearbyMerchantsTableView
        nearbyTableViewDataSource = NearbyTableViewDataSource(tableView: tableView, cellProvider: { (tableview, indexPath, merchant) -> UITableViewCell? in
            guard let cell = tableview.dequeueReusableCell(withIdentifier: MerchantTableCell.identifier, for: indexPath) as? MerchantTableCell else {return UITableViewCell()}
            cell.merchant = merchant
            return cell
        })
    }
    
    private func configureTableViewSnapshot() {
        nearbyTableViewSnapshot = NearbyTableViewSnapshot()
        nearbyTableViewSnapshot?.appendSections([.main])
        nearbyTableViewSnapshot?.appendItems(self.nearbyMearchants, toSection: .main)
        nearbyTableViewDataSource?.apply(nearbyTableViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func zoomRect(annotations: [MKAnnotation], width: Double, height: Double) {
        var mapRect = MKMapRect.null
        let edgePadding = UIEdgeInsets(top: 100, left: 100, bottom: 350, right: 100)
        
        if annotations.count > 1 {
            annotations.forEach { (annotation) in
                let annoRect = MKMapRect(origin: .init(annotation.coordinate), size: .init(width: width, height: height))
                mapRect = mapRect.union(annoRect)
            }
        } else {
            mapRect = MKMapRect(origin: .init(locationHandler.manager.location!.coordinate), size: .init(width: width, height: height))
        }
        
        mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
    }
    
    private func configureMerchantAnnotation() {
        service.fetchNearbyMerchants(location: locationHandler.manager.location!, withRadius: 0.25) { (merchant, merchantLocation) in
            let merchantAnnotation = MerchantAnnotation(merchantID: merchant.id, coordinate: merchantLocation.coordinate)
            self.mapView.addAnnotation(merchantAnnotation)
        }
        print("debugs : done set anno")
    }
    
    // MARK: - Targets
    @objc private func handleSwipeView(_ gesture: UISwipeGestureRecognizer) {
        
        
        if gesture.direction == .up {
            UIView.animate(withDuration: 0.3, animations: {
                self.nearbyMerchantListView.frame.origin.y = 300
                self.nearbyMerchantListView.frame.size.height = self.view.frame.height - 300
            }) { (_) in
                
            }
            
        }else if gesture.direction == .down {
            UIView.animate(withDuration: 0.3, animations: {
                self.nearbyMerchantListView.frame.origin.y = self.view.frame.height - NearbyMerchantListView.height
                self.nearbyMerchantListView.frame.size.height = NearbyMerchantListView.height
            }) { (_) in
                
            }
        }
    }

}


// MARK: - Map View Delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let merchantAnno = annotation as? MerchantAnnotation {
            let annotation = MKAnnotationView(annotation: merchantAnno, reuseIdentifier: MerchantAnnotation.identifier)
            annotation.image = #imageLiteral(resourceName: "UserLocation")
            annotation.setSize(width: 20, height: 26)
            return annotation
        }
        
        return nil
    }
}

// MARK: - Nearby Table View Delegate
extension MapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
}
