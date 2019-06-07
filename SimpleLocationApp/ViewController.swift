//
//  ViewController.swift
//  SimpleLocationApp
//
//  Created by Enrique Gonzalez on 5/21/19.
//  Copyright © 2019 Enrique Gonzalez. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let initialLocation = CLLocation(latitude: 37.7871434, longitude: -122.4008851)
    fileprivate let regionRadius: CLLocationDistance = 4000
    
    @IBOutlet weak var locationText: UITextView!
    fileprivate var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerMapOnLocation(location: initialLocation)
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
        locationManager.startUpdatingLocation()

    }
    
    fileprivate func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = false
        }
    }
    
    fileprivate func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        let lat : String = location.coordinate.latitude.description
        let lng : String = location.coordinate.longitude.description

        
        locationText.text = lat + ", " + lng
        
        centerMapOnLocation(location: location)
        
    }
    
}
