//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Kukuh Yoniatmoko on 22/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager: CLLocationManager = CLLocationManager()
    
    var annotations: [MKAnnotation]!
    var coordinatePosition = 0
    
    override func loadView() {
        locationManager.delegate = self
        mapView = MKMapView()
        mapView.delegate = self
        initAnnotations(mapView: mapView)
        view = mapView
        
        let standartString = NSLocalizedString("Standart", comment: "Standart map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Stellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(
            items:[
                standartString,
                hybridString,
                satelliteString
            ]
        )
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        view.addSubview(segmentedControl)
        
        let safeArea = view.safeAreaLayoutGuide
        segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8).isActive = true
        
        let margins = view.layoutMarginsGuide
        segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    
        initLocalizeButton(parent: mapView)
        initPinButton(parent: mapView)
    }
    
    private func initLocalizeButton(parent: UIView) {
        let safeArea = parent.safeAreaLayoutGuide
        let margins = parent.layoutMarginsGuide
        
        let button = UIButton.init(type: .system)
        button.setTitle("Localize", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(MapViewController.lockLocation(_:)), for: .touchUpInside)
        
        parent.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 8).isActive = true
        button.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
    
    private func initPinButton(parent: UIView) {
        let safeArea = parent.safeAreaLayoutGuide
        let margins = parent.layoutMarginsGuide
        
        let button = UIButton.init(type: .system)
        button.setTitle("Next Pin", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(MapViewController.nextPin(_:)), for: .touchUpInside)
        
        parent.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 8).isActive = true
        button.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    }
    
    private func initAnnotations(mapView: MKMapView) {
        let jakarta = MKPointAnnotation()
        jakarta.coordinate = CLLocationCoordinate2D(latitude: -6.1751, longitude: 106.8650)
        jakarta.title = "Jakarta"
        
        let manila = MKPointAnnotation()
        manila.coordinate = CLLocationCoordinate2D(latitude: 14.5995, longitude: 120.9842)
        manila.title = "Manila"
        
        let westJava = MKPointAnnotation()
        westJava.coordinate = CLLocationCoordinate2D(latitude: -7.0909, longitude: 107.6689)
        westJava.title = "West Java"
        
        annotations = [jakarta, manila, westJava]
        
        mapView.addAnnotation(jakarta)
        mapView.addAnnotation(manila)
        mapView.addAnnotation(westJava)
        
        mapView.showAnnotations([annotations[coordinatePosition]], animated: true)
    }
    
    @objc private func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .standard
        }
    }
    
    @objc private func lockLocation(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    @objc private func nextPin(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
        if coordinatePosition == annotations.count - 1 {
            coordinatePosition = 0
        } else {
            coordinatePosition = coordinatePosition + 1
        }
        mapView.showAnnotations([annotations[coordinatePosition]], animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.isEmpty {
            return
        }
        let location = locations[0]
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(region, animated: true)
    }
}
