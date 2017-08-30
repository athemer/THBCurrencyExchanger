//
//  MapViewController.swift
//  THBCurrencyExchanger
//
//  Created by 陳冠華 on 2017/8/23.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {


    @IBOutlet weak var mapView: UIView!

    let marker = GMSMarker()

//    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 10.0)

    let mapView2 = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 10.0))

    override func viewDidLoad() {
        super.viewDidLoad()

//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView2.isMyLocationEnabled = true
        self.mapView = mapView2

        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"

        marker.map = mapView2

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.




        // Creates a marker in the center of the map.



    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
