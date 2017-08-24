//
//  MapViewController.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/23.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MapViewController: UIViewController {


    @IBOutlet weak var mapView: UIView!
    
    
    let frame = CGRect(x: 50, y: 50, width: 100, height: 100)
    let color = UIColor.blue
    
    var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballBeat, color: color, padding: 10)
        activityIndicatorView.startAnimating()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
       activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballBeat, color: color, padding: 10)
    activityIndicatorView.stopAnimating()
        
    }


//    override func loadView() {
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
////        self.mapView = mapView
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismiss(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

}
