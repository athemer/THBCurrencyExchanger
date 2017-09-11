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

    var mapMarkerInfoWindow = MapMarkerInfoWindow()

    
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
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        let location = CLLocationCoordinate2D(latitude: (marker.userData as! location).lat, longitude: (marker.userData as! location).lon)
//
//        tappedMarker = marker
//        infoWindow.removeFromSuperview()
//        infoWindow = mapMarkerInfoWindow(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
//        infoWindow.Name.text = (marker.userData as! location).name
//        infoWindow.Price.text = (marker.userData as! location).price.description
//        infoWindow.Zone.text = (marker.userData as! location).zone.rawValue
//        infoWindow.center = mapView.projection.point(for: location)
//        infoWindow.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        self.view.addSubview(infoWindow)
//
//        // Remember to return false
//        // so marker event is still handled by delegate
//        return false
//    }
//
//    // let the custom infowindow follows the camera
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        if (tappedMarker.userData != nil){
//            let location = CLLocationCoordinate2D(latitude: (tappedMarker.userData as! location).lat, longitude: (tappedMarker.userData as! location).lon)
//            infoWindow.center = mapView.projection.point(for: location)
//        }
//    }
//
//    // take care of the close event
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        infoWindow.removeFromSuperview()
//    }



    @IBAction func dismiss(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

}
