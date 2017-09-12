//
//  MapViewController.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/23.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import GoogleMaps
import Hero
import Spring
import RealmSwift

class MapViewController: UIViewController, GMSMapViewDelegate {

    var bankModel = BankModel()

    var locationModels = List<LocationModel>()

    var mapView: GMSMapView?

    var tappedMarker = GMSMarker()

    var infoWindow: MapViewMarkerInfoWindow = {
        let view: MapViewMarkerInfoWindow = UIView.loadFromNibName(nibNamed: "MapViewMarkerInfoWindow", owner: nil, bundle: nil) as! MapViewMarkerInfoWindow
        
        view.layer.cornerRadius = 10
        view.getRoute.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect(x: 0, y: 0, width: 375, height: 667)

        let lati = CLLocationDegrees(Float(locationModels[0].latitude)!)
        let longi = CLLocationDegrees(Float(locationModels[0].longitude)!)

        print (" @@@@@ check for lati", lati, longi)

        var zoom: Float = 18.0

//        if locationModels.count > 1 {
//
//            zoom = 14.0
//
//        }

        mapView = GMSMapView.map(withFrame: frame, camera: GMSCameraPosition.camera(withLatitude: lati, longitude: longi, zoom: zoom))


//        mapView = GMSMapView.map(withFrame: frame, camera: GMSCameraPosition.camera(withLatitude: 23.123124, longitude: 121.214412, zoom: 16.0))


        mapView?.heroID = "mapView"

        mapView?.delegate = self

        addMarkerToMap()

        self.view.addSubview(mapView!)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addMarkerToMap() {


        for location in locationModels {

            let lati = CLLocationDegrees(Float(location.latitude)!)
            let longi = CLLocationDegrees(Float(location.longitude)!)

            let position = CLLocationCoordinate2D(latitude: lati, longitude: longi)

            let marker = GMSMarker(position: position)
            marker.title = self.bankModel.bankName
            marker.map = mapView

        }
    }

    //empty the default infowindow
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    // reset custom infowindow whenever marker is tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        tappedMarker = marker
        
        infoWindow.removeFromSuperview()
        
        infoWindow.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        
        infoWindow.center = mapView.projection.point(for: marker.position)
        
        infoWindow.center.y = infoWindow.center.y + 50
        
        infoWindow.bankNamLabel.text = "@@@@@"
        
        self.mapView?.addSubview(infoWindow)
        
        return false
    }
    
    // let the custom infowindow follows the camera
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        let location: CLLocationCoordinate2D = tappedMarker.position
        
        infoWindow.center = mapView.projection.point(for: location)
        
        infoWindow.center.y = infoWindow.center.y + 50
        
    }
    
    // take care of the close event
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }
    
    
    
    

    func openMap() {
        
        let lati = self.tappedMarker.position.latitude
        let longi = self.tappedMarker.position.longitude
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            
            let directionsRequest = "comgooglemaps-x-callback://" +
                "?daddr=\(lati),\(longi)" +
            "&x-success=sourceapp://?resume=true&x-source=AirApp"
            
            let directionsURL = URL(string: directionsRequest)!
            UIApplication.shared.openURL(directionsURL)
            
            
        } else {
            
            print("Can't use comgooglemaps://")
            
        }
        
        
        print (" OPEN MAP ")
        
    }

    @IBAction func dismiss(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

}
