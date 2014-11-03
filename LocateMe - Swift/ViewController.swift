//
//  ViewController.swift
//  LocateMe - Swift
//
//  Created by Jian Yao Ang on 11/3/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var coordinatesLabel: UILabel!
    @IBOutlet var locateMeButton: UIButton!
    var locationCoordinates: CLLocationCoordinate2D!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
    @IBAction func onLocateMeButtonPressed(sender: AnyObject)
    {
        searchUser()
    }

    func searchUser(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        
        self.locationCoordinates = manager.location.coordinate
        self.locationManager.stopUpdatingLocation()
        println("locations = \(self.locationCoordinates.latitude) \(self.locationCoordinates.longitude)")
        
        self.coordinatesLabel.text = "\(self.locationCoordinates.latitude), \(self.locationCoordinates.longitude)"
        
        displayUserLocationOnMap()
    }
    
    func displayUserLocationOnMap(){
        let location = CLLocationCoordinate2D(latitude:self.locationCoordinates.latitude, longitude:self.locationCoordinates.longitude)
        
        let coordinateSpan = MKCoordinateSpanMake(0.2,0.5)
        let coordinateRegion = MKCoordinateRegion(center: location, span: coordinateSpan)
        self.mapView.setRegion(coordinateRegion, animated: true)
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.setCoordinate(location)
        pointAnnotation.title = "My Location"
        self.mapView.addAnnotation(pointAnnotation)
        
        
    }
}

