//
//  ViewController.swift
//  SimpleLocationApp
//
//  Created by Enrique Gonzalez on 5/21/19.
//  Copyright © 2019 Enrique Gonzalez. All rights reserved.
//

import UIKit
import MapKit
import os.log

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let initialLocation = CLLocation(latitude: 37.7871434, longitude: -122.4008851)
    fileprivate let regionRadius: CLLocationDistance = 4000
    
    @IBOutlet weak var locationText: UITextView!
    fileprivate var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationText.isEditable = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }

    }
    
    fileprivate func checkLocationAuthorizationStatus() {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true

    }
    
    fileprivate func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        manager.stopUpdatingLocation()
        let location = locations.last! as CLLocation
        
        let latNum : Double = round(location.coordinate.latitude*1000)/1000
        let longNum : Double = round(location.coordinate.longitude*1000)/1000
        
        let lat : String = String(latNum)
        let lng : String = String(longNum)

        
        locationText.text = lat + ", " + lng
        os_log("Latitude: %s Longitude: %s.", lat, lng)
        manager.startUpdatingLocation()
        centerMapOnLocation(location: location)
        
    }
    
}
