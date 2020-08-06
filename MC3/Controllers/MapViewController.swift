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
    
    private var merchantDetailView = MerchantDetailView()
    
    private var nearbyMerchants: [Merchant] = [Merchant]() {
        didSet {
            let userLocation = locationHandler.manager.location!
            self.nearbyMerchants = self.nearbyMerchants.sorted{  (merchant1, merchant2) -> Bool in
                merchant1.location.distance(from: userLocation) < merchant2.location.distance(from: userLocation)
            }
            self.configureTableViewSnapshot(data: self.nearbyMerchants)
            zoomRect(annotations: self.mapView.annotations, width: 0.1, height: 0.1)
        }
    }
    
    private let service = FirebaseService.shared
    private var merchantRoute: MerchantRoute? {
        didSet {
            self.merchantDetailView.merchantDetails = merchantRoute
        }
    }

    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNearbyMerchantListView()
        configureUI()
        fetchNearbyMerchants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.nearbyMerchantListView.frame.origin.y = self.view.frame.height - NearbyMerchantListView.height
        }, completion: nil)
        
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
        
        self.mapView.addSubview(nearbyMerchantListView) {
            self.nearbyMerchantListView.frame = CGRect(x: 0, y: self.mapView.frame.height, width: self.mapView.frame.width, height: NearbyMerchantListView.height)
        }

        self.mapView.addSubview(merchantDetailView) {
            self.merchantDetailView.frame = CGRect(x: 0, y: self.mapView.frame.height, width: self.mapView.frame.width, height: MerchantDetailView.height)
            self.merchantDetailView.delegate = self
        }
    }
    
    private func configureNearbyMerchantListView() {
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeView(_:)))
        swipeDownGesture.direction = .down
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeView(_:)))
        swipeUpGesture.direction = .up
        
        self.nearbyMerchantListView.addGestureRecognizer(swipeDownGesture)
        self.nearbyMerchantListView.addGestureRecognizer(swipeUpGesture)
        
        nearbyMerchantListView.configureTableView(delegate: self)
        configureTableViewDataSource()
        
    }
    
    private func configureTableViewDataSource() {
        let tableView = nearbyMerchantListView.nearbyMerchantsTableView
        nearbyTableViewDataSource = NearbyTableViewDataSource(tableView: tableView, cellProvider: { (tableview, indexPath, merchant) -> UITableViewCell? in
            guard let cell = tableview.dequeueReusableCell(withIdentifier: MerchantTableCell.identifier, for: indexPath) as? MerchantTableCell else {return UITableViewCell()}
            cell.merchant = merchant
            cell.configureComponents()
            return cell
        })
    }
    
    private func configureTableViewSnapshot(data: [Merchant]) {
        nearbyTableViewSnapshot = NearbyTableViewSnapshot()
        nearbyTableViewSnapshot!.appendSections([.main])
        nearbyTableViewSnapshot!.appendItems(data, toSection: .main)
        nearbyTableViewDataSource!.apply(nearbyTableViewSnapshot!, animatingDifferences: true, completion: nil)
    }
    
    private func zoomRect(annotations: [MKAnnotation], width: Double, height: Double) {
        var mapRect = MKMapRect.null
        let edgePadding: UIEdgeInsets = UIEdgeInsets(top: 150, left: 150, bottom: 350, right: 150)
        
        if annotations.count > 1 {
            annotations.forEach { (annotation) in
                let annoRect = MKMapRect(origin: .init(annotation.coordinate), size: .init(width: width, height: height))
                mapRect = mapRect.union(annoRect)
            }
        } else {
            if let annotation = annotations.first as? MerchantAnnotation {
                mapRect = MKMapRect(origin: .init(annotation.coordinate), size: .init(width: width, height: height))
            } else {
                mapRect = MKMapRect(origin: .init(locationHandler.manager.location!.coordinate), size: .init(width: width, height: height))
            }
        }
        
        mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
    }
    
    private func maximizeMerchantListView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.nearbyMerchantListView.frame.origin.y = 300
            self.nearbyMerchantListView.frame.size.height = self.view.frame.height - 300
        }) { (_) in
            
        }
    }
    
    private func minimizeMerchantListView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.nearbyMerchantListView.frame.origin.y = self.view.frame.height - NearbyMerchantListView.height
            self.nearbyMerchantListView.frame.size.height = NearbyMerchantListView.height
        }) { (_) in
            
        }
    }
    
    private func showMerchantDetailView() {
        UIView.animate(withDuration: 0.3) {
            self.merchantDetailView.frame.origin.y = self.mapView.frame.height - MerchantDetailView.height
        }
    }
    
    private func showSelectedMerchantDetail(selectedMerchant: Merchant) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = locationHandler.manager.location!.coordinate
        
        self.mapView.annotations.forEach { (annotation) in
            if let annotation = annotation as? MerchantAnnotation {
                if annotation.merchant.id == selectedMerchant.id {
                    print(userAnnotation,annotation)
                    self.zoomRect(annotations: [userAnnotation,annotation], width: 0.1, height: 0.1)
                } else {
                    self.mapView.removeAnnotation(annotation)
                }
            }
        }
        
        self.minimizeMerchantListView()
        self.nearbyMerchantListView.alpha = 0
        self.showMerchantDetailView()
    }
    
    private func fetchNearbyMerchants() {
        var merchants = [Merchant]()
        service.fetchNearbyMerchants(location: locationHandler.manager.location!, withRadius: 0.2) { (merchant, merchantLocation) in
            let merchAnno = MerchantAnnotation(merchant: merchant, coordinate: merchantLocation.coordinate)
            self.mapView.addAnnotation(merchAnno)
            DispatchQueue.main.async {
                merchants.append(merchant)
                self.nearbyMerchants = merchants
            }
            
        }
        
    }
    
    private func requestDirectionTo(_ merchant: Merchant) {
        let request = MKDirections.Request()
        request.transportType = .walking
        let origin = MKMapItem(placemark: MKPlacemark(coordinate: locationHandler.manager.location!.coordinate))
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: merchant.location.coordinate))
        
        request.source = origin
        request.destination = destination
        
        let direction = MKDirections(request: request)
        direction.calculate { (response, error) in
            if let err = error {
                print("ERROR : ",err.localizedDescription)
                return
            }
            
            guard let route = response?.routes.last else {return}
            let minutes = (route.expectedTravelTime/60).rounded()
            self.mapView.addOverlay(route.polyline)
            self.merchantRoute = MerchantRoute(merchant: merchant, origin: origin, destination: destination, route: route, estimatedTime: minutes)
        }
    }
    
    // MARK: - Targets
    @objc private func handleSwipeView(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            self.maximizeMerchantListView()
        }else if gesture.direction == .down {
            self.minimizeMerchantListView()
        }
    }

}


// MARK: - Map View Delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let merchantAnno = annotation as? MerchantAnnotation {
            let annotation = MKAnnotationView(annotation: merchantAnno, reuseIdentifier: MerchantAnnotation.identifier)
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 7)
            label.text = merchantAnno.merchant.name
            annotation.image = #imageLiteral(resourceName: "locationPoint")
            annotation.setSize(width: 20, height: 26)
            
            annotation.addSubview(label) {
                label.setSize(width: 70, height: 9)
                label.setAnchor(bottom: annotation.bottomAnchor)
                label.setCenterXAnchor(in: annotation)
            }
            
            return annotation
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemTeal
            renderer.lineWidth = 4
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MerchantAnnotation {
            self.requestDirectionTo(annotation.merchant)
            showSelectedMerchantDetail(selectedMerchant: annotation.merchant)
        }
    }
}

// MARK: - Nearby Table View Delegate
extension MapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedMerchant = nearbyTableViewDataSource?.itemIdentifier(for: indexPath) else {return}
        self.requestDirectionTo(selectedMerchant)
        showSelectedMerchantDetail(selectedMerchant: selectedMerchant)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
}

// MARK: - Merchant Detail View Delegate
extension MapViewController: MerchantDetailViewDelegate {
    func getDirectionToSelectedMerchant(_ routeInfo: MerchantRoute) {
        self.mapView.annotations.forEach { (annotation) in
            if let annotation = annotation as? MKUserLocation {
                self.mapView.camera.pitch = 85.0
                self.mapView.camera.altitude = 200.0
                self.mapView.camera.centerCoordinate = annotation.coordinate
                self.mapView.isPitchEnabled = true
            }
        }
    }
    
    func hideMerchantDetailView() {
        UIView.animate(withDuration: 0.3) {
            self.merchantDetailView.frame.origin.y = self.mapView.frame.height
            self.nearbyMerchantListView.alpha = 1
        }
        self.mapView.removeOverlays(self.mapView.overlays)
        fetchNearbyMerchants()
        zoomRect(annotations: self.mapView.annotations, width: 0.1, height: 0.1)
    }
    
}
