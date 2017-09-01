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

class MapViewController: UIViewController {


//    @IBOutlet weak var mapView: GMSMapView!
    var mapView:GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect(x: 0, y: 200, width: 375, height: 300)
        
        mapView = GMSMapView.map(withFrame: frame, camera: GMSCameraPosition.camera(withLatitude: 25.029324, longitude: 121.441211, zoom: 16.0))
        
        //so the mapView is of width 200, height 200 and its center is same as center of the self.view
        mapView?.center = self.view.center
        mapView?.heroID = "mapView"
        
        
        self.view.addSubview(mapView!)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)



    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismiss(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

}
